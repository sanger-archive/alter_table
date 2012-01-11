require 'spec_helper'

describe AlterTable::TableAlterer::ColumnAlterations do
  include_context 'ActiveRecord configuration'

  subject { alterer }

  describe '#add_column' do
    it 'handles the simple type case' do
      subject.should_receive(:push_alterations).with('ADD COLUMN foo string')
      subject.add_column(:foo, :string)
    end

    it 'handles the options' do
      subject.should_receive(:push_alterations).with('ADD COLUMN foo integer(10)')
      subject.add_column(:foo, :decimal, :precision => 10)
    end
  end

  describe '#remove_column' do
    it 'handles the simple case' do
      subject.should_receive(:push_alterations).with('DROP COLUMN foo')
      subject.remove_column(:foo)
    end

    it 'handles multiple columns' do
      subject.should_receive(:push_alterations).with('DROP COLUMN foo', 'DROP COLUMN bar')
      subject.remove_column(:foo, :bar)
    end
  end

  describe '#rename_column' do
    it 'handles the simple case' do
      subject.should_receive(:push_alterations).with('CHANGE COLUMN foo bar string')
      subject.rename_column(:foo, :bar, :string)
    end

    it 'handles the options' do
      subject.should_receive(:push_alterations).with('ADD COLUMN foo integer(10)')
      subject.add_column(:foo, :decimal, :precision => 10)
    end
  end
end
