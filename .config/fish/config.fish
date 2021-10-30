if status is-interactive
	# add SSH identities to ssh-agent if we haven't already done so
	if ssh-add -l | grep "The agent has no identities" > /dev/null
		ssh-add
	end
end
