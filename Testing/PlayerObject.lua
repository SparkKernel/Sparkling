-- This is a testing-file
-- This is hard-coded asf (bc its for testing lol)
RegisterCommand('test', function(src)
    SparkClient:Run(src, 'Test', function(resp)
        print(resp)
    end)
end)

RegisterCommand('test123', function(src, args)
    local User = Sparkling.Users:Get(args[1])
    User.Admin:Unban()
end)