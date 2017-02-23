require 'spec_helper'

describe autoscaling_group($terraform_output['public_asg_id']['value']) do
  it { should exist }
end

describe autoscaling_group($terraform_output['private_asg_id']['value']) do
  it { should exist }
end

describe ec2('awspec-testing-public') do
	it { should exist }
	it { should have_security_group($terraform_output['security_group_id']['value']) }
	it { should belong_to_vpc($terraform_output['vpc_id']['value']) }
end
