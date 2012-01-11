require 'spec_helper'

describe AlterTable::TableAlterer::IndexAlterations do
  include_context 'ActiveRecord configuration'

  subject do
    alterer.class_eval do
      def table
        'test_table'
      end
    end
    alterer
  end

  describe '#add_index' do
    it 'handles the simple case' do
      subject.should_receive(:push_alterations).with('ADD INDEX index_test_table_on_foo  (foo)')
      subject.add_index(:foo)
    end

    it 'handles multiple column indices' do
      subject.should_receive(:push_alterations).with('ADD INDEX index_test_table_on_foo_and_bar  (foo, bar)')
      subject.add_index([ :foo, :bar ])
    end
  end

  describe '#remove_index' do
    it 'handles the simple case' do
      subject.should_receive(:push_alterations).with('DROP INDEX index_test_table_on_foo')
      subject.remove_index(:foo)
    end
  end
end
