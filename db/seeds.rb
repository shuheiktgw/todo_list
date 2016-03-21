10.times do |i|
	User.create(
		email: "example#{i}@example.com",
		password: "password"
	)
end


100.times do |i|
	Task.create(
		user_id: 1,
		name: "Task#{i}",
		description: "#{'test '*10}",
		urgency: 0,
		importance: 0,
		status: 0
	)
end
