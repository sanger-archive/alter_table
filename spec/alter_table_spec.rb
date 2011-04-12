require 'spec_helper'

describe ActiveRecord::ConnectionAdapters::AbstractAdapter do
  before(:each) do
    @connection = mock('Connection')
  end

  subject { ActiveRecord::ConnectionAdapters::AbstractAdapter.new(@connection) }

  it { respond_to?(:alter_table) }

  describe '#alter_table' do
    it 'handles simple case' do
      subject.should_receive(:execute).with('ALTER TABLE table_1 ADD COLUMN foo string')

      subject.alter_table(:table_1) do
        add_column(:foo, :string)
      end
    end

    it 'handles multiple alterations' do
      subject.should_receive(:execute).with('ALTER TABLE table_1 ADD COLUMN foo string, DROP COLUMN bar')

      subject.alter_table(:table_1) do
        add_column(:foo, :string)
        remove_column(:bar)
      end
    end
  end
end
