require 'spec_helper'

module RubySMB
RSpec.describe Field do
  describe 'CONSTRUCTION' do
    describe '#new()' do
      let(:field) { Field.new }

      it 'sets READER fields  to DEFAULT = empty array' do
        expect(field.children).to eql []
      end

      it 'sets READER name    to DEFAULT = nil' do
        expect(field.name).to be_nil
      end


      it 'sets READER n_bytes to DEFAULT = 0' do
        expect(field.n_bytes).to eql 0
      end


      it 'sets READER value   to DEFAULT = empty string' do
        expect(field.value).to eql ''
      end
    end

    describe '#new(args)' do
      it 'sets READER children' do
        field = Field.new(children: [child_1 = double('child_1'),
                                     child_2 = double('child_2'),
                                     child_3 = double('child_3')])

        expect(field.children).to eql [child_1, child_2, child_3]
      end

      it 'sets READER name' do
        field = Field.new(name: :abstract)
        expect(field.name).to eql :abstract
      end

      it 'sets READER n_bytes' do
        field = Field.new(n_bytes: 4)
        expect(field.n_bytes).to eql 4
      end

      it 'sets READER value' do
        field = Field.new(value: "\xFFabstract")
        expect(field.value).to eql "\xFFabstract"
      end

      it 'sets READER binary_s' do
        field = Field.new(n_bytes: 9, value: "\xFFabstract")
        expect(field.binary_s).to eql "\xFFabstract"
      end
    end
  end

  describe 'READERS' do
    describe '#binary_s' do
      context 'allocated > value' do
        it 'adds NULL padding' do
          field = Field.new(n_bytes:  8,
                              value:  "\xFFYOLO\x00")

          expect(field.binary_s).to eql "\xFFYOLO\x00" +
                                        "\x00\x00"
        end
      end

      context 'allocated = value' do
        it 'does NOT add NULL padding' do
          field = Field.new(n_bytes:  6,
                              value:  "\xFFYOLO\x00")

          expect(field.binary_s).to eql "\xFFYOLO\x00"
        end
      end

      context 'allocated < value' do
        it 'truncates the value' do
        field = Field.new(n_bytes: 4,
                            value:  "\xFFYOLO\x00")

          expect(field.binary_s).to eql "\xFFYOL"
        end
      end
    end
  end

  describe 'WRITERS' do
    let(:child_1)   { double('child_1') }
    let(:child_2)   { double('child_2') }
    let(:child_3)   { double('child_3') }
    let(:children)  { [child_1, child_2, child_3] }

    let(:field)     { Field.new(children:  children,
                                    name:  :abstract,
                                 n_bytes:  2,
                                   value:  "\xFFART\x00") }
    describe '#children=' do
      it 'updates children' do
        field = Field.new(children: [child_1 = double('child_1'),
                                     child_2 = double('child_2'),
                                     child_3 = double('child_3')])


        expect{ field.children = [child_1, child_3] }.to \
          change{ field.children }.from([child_1, child_2, child_3])
                                  .to([child_1, child_3])
      end
    end

    describe '#name=' do
      it 'updates name' do
        field = Field.new(name: :abstract)

        expect{ field.name = :concrete}.to \
        change{ field.name }.from(:abstract)
                              .to(:concrete)
      end
    end

    describe '#n_bytes=' do
      it 'updates n_bytes' do
        field = Field.new(n_bytes: 4)

        expect{ field.n_bytes = 2}.to \
        change{ field.n_bytes }.from(4)
                                 .to(2)
      end
    end

    describe '#value=' do
      it 'updates value' do
        field = Field.new(value: "\xFFYOLO")

        expect{ field.value = "\x00Bro"}.to \
        change{ field.value }.from("\xFFYOLO")
                             .to("\x00Bro")
      end
    end

    describe '#add_child' do
      it 'pushes a child into the other children' do
        field = Field.new(children: [child_1 = double('child_1'),
                                     child_2 = double('child_2')])

        expect{ field.add_child child_3 }.to \
          change{ field.children }.from([child_1, child_2])
                                  .to([child_1, child_2, child_3])
      end
    end

    describe '#delete_child' do
      it 'erases a child right in front of the other children' do
        field = Field.new(children: [child_1 = double('child_1'),
                                     child_2 = double('child_2'),
                                     child_3 = double('child_3')])

        expect{ field.delete_child child_2 }.to \
          change{ field.children }.from([child_1, child_2, child_3])
                                  .to([child_1, child_3])
      end
    end
  end
end
end
