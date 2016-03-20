FactoryGirl.define do
	factory :group do
		sequence(:name) {|n| "Group#{n}"}
		description 'This is a test group'
	end
end