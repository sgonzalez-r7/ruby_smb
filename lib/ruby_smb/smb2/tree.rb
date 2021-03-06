# A connected tree, as returned by a {RubySMB::SMB2::Packet::TreeConnectRequest}.
class RubySMB::SMB2::Tree

  # The {SMB2::Client} on which this Tree is connected.
  #
  # @return [RubySMB::SMB2::Client]
  attr_accessor :client

  # The name of the share this Tree operates on
  #
  # @return [String]
  attr_accessor :share

  # The response that occasioned the creation of this {Tree}.
  #
  # @return [RubySMB::SMB2::Packet::TreeConnectResponse]
  attr_accessor :tree_connect_response

  # The NTStatus code received from the {SMB2::Packet::TreeConnectResponse}
  #
  # @return [WindowsError::ErrorCode] the NTStatus code object
  attr_accessor :tree_connect_status

  # @param client [SMB::Client] (see {#client})
  # @param share [String] (see {#share})
  # @param tree_connect_response [SMB::Packet::TreeConnectResponse]
  def initialize(client:, share:, tree_connect_response:)
    unless tree_connect_response.is_a?(RubySMB::SMB2::Packet::TreeConnectResponse)
      raise ArgumentError, "tree_connect_response must be a TreeConnectResponse"
    end

    self.client = client
    self.share = share
    self.tree_connect_response = tree_connect_response
    self.tree_connect_status = WindowsError::NTStatus.find_by_retval(tree_connect_response.nt_status).first
  end

  # Open a file handle
  #
  # The protocol is persnickety about format. The `filename` must not begin
  # with a backslash or it will return a STATUS_INVALID_PARAMETER.
  #
  # If the optional code block is given, it will be passed the opened file as
  # an argument and the {File} object will automatically be {File#close
  # closed} when the block terminates. The value of the block will be
  # returned.
  #
  # @param filename [String,#encode] this will be encoded in utf-16le
  # @param mode [String] See stdlib ::File#mode
  # @yield [RubySMB::SMB2::File]
  # @return [RubySMB::SMB2::File] if no block given
  # @return [Object] value of the block if block given
  def create(filename, mode = "r+")
    desired_access = desired_access_from_mode(mode)
    create_options = RubySMB::SMB2::Packet::CREATE_OPTIONS[:FILE_NON_DIRECTORY_FILE]
    share_access =
      RubySMB::SMB2::Packet::SHARE_ACCESS[:FILE_SHARE_READ] |
      RubySMB::SMB2::Packet::SHARE_ACCESS[:FILE_SHARE_WRITE]

    packet = RubySMB::SMB2::Packet::CreateRequest.new(
      create_options: create_options,
      desired_access: desired_access,
      disposition: disposition_from_file_mode(mode),
      filename: filename.encode("utf-16le"),
      impersonation: RubySMB::SMB2::Packet::IMPERSONATION_LEVELS[:IMPERSONATION],
      share_access: share_access,
    )

    response = send_recv(packet)

    create_response = RubySMB::SMB2::Packet::CreateResponse.new(response)
    file = RubySMB::SMB2::File.new(filename: filename, tree: self, create_response: create_response)
    if mode.start_with?("a")
      file.seek(create_response.end_of_file)
    end

    if block_given?
      value = yield file
      file.close
      value
    else
      file
    end
  end

  # Remove `filename` on the remote share.
  #
  # @example
  #   tree = client.tree_connect("\\\\192.168.99.134\\Share")
  #   tree.delete("path\\to\\remove_me.txt")
  #
  # @param filename [String] path to the file to be removed
  # @return [void]
  def delete(filename)
    share_access =
      RubySMB::SMB2::Packet::SHARE_ACCESS[:FILE_SHARE_READ] |
      RubySMB::SMB2::Packet::SHARE_ACCESS[:FILE_SHARE_WRITE] |
      RubySMB::SMB2::Packet::SHARE_ACCESS[:FILE_SHARE_DELETE]

    packet = RubySMB::SMB2::Packet::CreateRequest.new(
      create_options: RubySMB::SMB2::Packet::CREATE_OPTIONS[:FILE_DELETE_ON_CLOSE],
      desired_access: RubySMB::SMB2::Packet::FILE_ACCESS_MASK[:DELETE],
      disposition: RubySMB::SMB2::Packet::CREATE_DISPOSITIONS[:FILE_OPEN],
      filename: filename.encode("utf-16le"),
      impersonation: RubySMB::SMB2::Packet::IMPERSONATION_LEVELS[:IMPERSONATION],
      share_access: share_access,
    )

    response = send_recv(packet)

    create_response = RubySMB::SMB2::Packet::CreateResponse.new(response)
    file = RubySMB::SMB2::File.new(
      filename: filename,
      tree: self,
      create_response: create_response
    )
    file.close
  end

  # @return [String]
  def inspect
    if tree_connect_response.nt_status != WindowsError::NTStatus::STATUS_SUCCESS
      stuff = "Error: #{tree_connect_status.name}"
    else
      stuff = share
    end
    "#<#{self.class} #{stuff} >"
  end

  # List `directory` on the remote share.
  #
  # @example
  #   tree = client.tree_connect("\\\\192.168.99.134\\Share")
  #   tree.list(directory: "path\\to\\directory")
  #
  # @param directory [String] path to the directory to be listed
  # @param pattern [String] search pattern
  # @param type [Symbol] file information class
  # @return [Array] array of directory structures
  # @todo refactor this method to not rely on exceptions
  # @todo refactor exception-with-inspect pattern to use logging
  def list(directory: nil, pattern: '*', type: :FileNamesInformation)
    create_request = RubySMB::SMB2::Packet::CreateRequest.new(
      impersonation: RubySMB::SMB2::Packet::IMPERSONATION_LEVELS[:IMPERSONATION],
      desired_access: RubySMB::SMB2::Packet::DIRECTORY_ACCESS_MASK[:FILE_LIST_DIRECTORY],
      share_access: RubySMB::SMB2::Packet::SHARE_ACCESS[:FILE_SHARE_READ],
      disposition: RubySMB::SMB2::Packet::CREATE_DISPOSITIONS[:FILE_OPEN],
      create_options: RubySMB::SMB2::Packet::CREATE_OPTIONS[:FILE_DIRECTORY_FILE]
    )

    # TODO: add some inline doc for this if block
    # TODO: change magic format string to be a constant
    if directory
      create_request.filename = directory.encode('utf-16le')
    else
      create_request.filename = "\x00"
      create_request.filename_length = 0
    end

    response = send_recv(create_request)
    create_response = RubySMB::SMB2::Packet::CreateResponse.new(response)

    unless create_response.nt_status == WindowsError::NTStatus::STATUS_SUCCESS
      raise create_response.inspect
    end

    directory_request = RubySMB::SMB2::Packet::QueryDirectoryRequest.new(
      file_info_class: RubySMB::SMB2::Packet::FILE_INFORMATION_CLASSES[type],
      file_id: create_response.file_id,
      file_name: pattern.encode('utf-16le')
    )

    class_array = []

    loop do
      response = send_recv(directory_request)
      directory_response = RubySMB::SMB2::Packet::QueryDirectoryResponse.new(response)

      break if directory_response.nt_status == WindowsError::NTStatus::STATUS_NO_MORE_FILES

      unless directory_response.nt_status == WindowsError::NTStatus::STATUS_SUCCESS
        raise directory_response.inspect
      end

      blob = directory_response.output_buffer
      klass = RubySMB::SMB2::Packet::Query::FILE_INFORMATION_CLASSES[type]

      class_array += RubySMB::SMB2::Packet::Query.class_array_from_blob(blob, klass)
    end

    class_array
  end

  # Send a packet and return the response
  #
  # @param request [RubySMB::SMB2::Packet]
  # @return (see Client#send_recv)
  def send_recv(request)
    request.tree_id = self.tree_connect_response.tree_id
    request.process_id = 0

    client.send_recv(request)
  end

  private

  def desired_access_from_mode(mode)
    # Read-only is our base access here.
    base_access_mask = RubySMB::SMB2::Packet::FILE_ACCESS_MASK[:FILE_READ_DATA] |
      RubySMB::SMB2::Packet::FILE_ACCESS_MASK[:FILE_READ_EA] |
      RubySMB::SMB2::Packet::FILE_ACCESS_MASK[:FILE_READ_ATTRIBUTES] |
      RubySMB::SMB2::Packet::FILE_ACCESS_MASK[:READ_CONTROL] |
      RubySMB::SMB2::Packet::FILE_ACCESS_MASK[:SYNCHRONIZE]
    case mode
    when "r+", "w+", "a+", "w", "a"
      # read/write and write-only. Samba's smbclient sets all the read flags
      # when writing, so emulate that.
      access_mask = base_access_mask |
        RubySMB::SMB2::Packet::FILE_ACCESS_MASK[:FILE_WRITE_DATA] |
        RubySMB::SMB2::Packet::FILE_ACCESS_MASK[:FILE_APPEND_DATA] |
        RubySMB::SMB2::Packet::FILE_ACCESS_MASK[:FILE_WRITE_EA] |
        RubySMB::SMB2::Packet::FILE_ACCESS_MASK[:FILE_WRITE_ATTRIBUTES]
    when "r"
      access_mask = base_access_mask
    else
      raise ArgumentError, "mode is not a valid file mode"
    end
    access_mask
  end

  def disposition_from_file_mode(mode)
    case mode
    when "r", "r+"
      RubySMB::SMB2::Packet::CREATE_DISPOSITIONS[:FILE_OPEN]
    when "w", "w+"
      # truncate
      RubySMB::SMB2::Packet::CREATE_DISPOSITIONS[:FILE_OVERWRITE_IF]
    when "a", "a+"
      RubySMB::SMB2::Packet::CREATE_DISPOSITIONS[:FILE_OPEN_IF]
    else
      raise ArgumentError, "mode is not a valid file mode"
    end
  end

end
