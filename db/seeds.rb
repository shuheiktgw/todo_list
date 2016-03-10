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
