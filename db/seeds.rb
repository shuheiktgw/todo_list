100.times do
	Task.create(
		user_id: 1,
		name: "Task",
		urgency: 0,
		importance: 0,
		status: 0
	)
end
