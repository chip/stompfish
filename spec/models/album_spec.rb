require 'spec_helper'

describe Album do
  it { should belong_to(:artist) }
end
