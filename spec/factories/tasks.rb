FactoryGirl.define do
	factory :task do
		user
		name "test"
		urgency :urgency_low
		importance :importance_low
		status :not_yet
	end
end

