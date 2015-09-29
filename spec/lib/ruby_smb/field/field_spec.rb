require 'spec_helper'

module RubySMB
module SMB_Field
RSpec.describe Field do
  describe 'CONSTRUCTION' do
    describe '#new() - Reader DEFAULTS' do
      let(:field) { Field.new }

      it 'sets fields to DEFAULT = empty array' do
        expect(field.children).to eql []
      end

      it 'sets name to DEFAULT = nil' do
        expect(field.name).to be_nil
      end


      it 'sets n_bytes to DEFAULT = 0' do
        expect(field.n_bytes).to eql 0
      end


      it 'sets value to DEFAULT = empty string' do
        expect(field.value).to eql ''
      end
    end

    describe '#new(args) - set Readers' do
      let(:child_1)   { double('child_1') }
      let(:child_2)   { double('child_2') }
      let(:child_3)   { double('child_3') }
      let(:children)  { [child_1, child_2, child_3] }

      let(:field)    { Field.new(children:  children,
                                     name:  :abstract,
                                  n_bytes:  5,
                                    value:  "\xFFART\x00") }
      it 'sets children' do
        expect(field.children).to eql [child_1, child_2, child_3]
      end

      it 'sets name' do
        expect(field.name).to eql :abstract
      end

      it 'sets n_bytes' do
        expect(field.n_bytes).to eql 5
      end

      it 'sets value' do
        expect(field.value).to eql "\xFFART\x00"
      end

      it 'sets binary_s' do
        expect(field.binary_s).to eql "\xFFART\x00"
      end
    end
  end

  describe 'READERS' do
    describe '#binary_s' do
      context 'allocated > value' do
        let(:field)    { Field.new(n_bytes:  8,
                                     value:  "\xFFYOLO\x00") }
        it 'adds NULL padding' do
          expect(field.binary_s).to eql "\xFFYOLO\x00" +
                                        "\x00\x00"
        end
      end

      context 'allocated = value' do
        let(:field)    { Field.new(n_bytes:  6,
                                     value:  "\xFFYOLO\x00") }
        it 'does NOT add NULL padding' do
          expect(field.binary_s).to eql "\xFFYOLO\x00"
        end
      end

      context 'allocated < value' do
        let(:field)    { Field.new(n_bytes: 4,
                                     value:  "\xFFYOLO\x00") }
        it 'truncates the value' do
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
      it 'sets children' do
        expect{field.children = [child_1, child_3]}.to \
          change{field.children}.from([child_1, child_2, child_3])
                                .to([child_1, child_3])
      end
    end

    describe '#name=' do
      it 'sets name' do
        expect{field.name = :concrete}.to \
          change{field.name}.from(:abstract).to(:concrete)
      end
    end

    describe '#n_bytes=' do
      it 'sets n_bytes' do
        expect{field.n_bytes = 4}.to \
          change{field.n_bytes}.from(2).to(4)
      end
    end

    describe '#value=' do
      it 'sets value' do
        expect{field.value = "\xFFPOOF"}.to \
          change{field.value}.from("\xFFART\x00").to("\xFFPOOF")
      end
    end

    describe '#add_child' do
      let(:child_4) { double('child_4') }

      it 'pushes a child into the other children' do
        expect{field.add_child child_4}.to \
          change{field.children}.from([child_1, child_2, child_3])
                                .to([child_1, child_2, child_3, child_4])
      end
    end

    describe '#delete_child' do
      it 'erases a child right in front of the other children' do
        expect{field.delete_child(child_2)}.to \
          change{field.children}.from([child_1, child_2, child_3])
                                .to([child_1, child_3])
      end
    end
  end
end
end
end
