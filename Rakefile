# Remote Testing Android

def remote_android_tests(deviceName, platformName, platformVersion, appiumVersion)
  environment_variables = {
    'REMOTE' => 'true',
    'PARALLEL_SPLIT_TEST_PROCESSES' => ARGV[1],
    'deviceName' => deviceName,
    'platformName' => platformName,
    'platformVersion' => platformVersion
  }
  system(environment_variables, "parallel_split_test spec/*_spec.rb --format progress --format RspecJunitFormatter --out test_results/results.xml --format ParallelTests::RSpec::FailuresLogger --out test_results/failed_tests.log #{ENV['test_options']}")
  fail 'remote_android_tests' unless $?.exitstatus == 0
end

def local_android_tests(deviceName, platformName, platformVersion, appiumVersion)
  environment_variables = {
    'LOCAL' => 'true',
    'deviceName' => deviceName,
    'platformName' => platformName,
    'platformVersion' => platformVersion
  }
  system(environment_variables, "rspec spec/*_spec.rb #{ENV['test_options']}")
  fail 'local_android_tests' unless $?.exitstatus == 0
end

# Android Emulators
task :Android_Emulator do
  remote_android_tests('Android Emulator', 'Android', '5.1', '1.5.3')
end

# Local Android Device
task :Local_Android do
  local_android_tests('Nexus_6_API_22', 'Android', '5.1', '1.5.3')
end

multitask :test_sauce => [
    :Android_Emulator
  ] do
    puts 'Running Bonnie Test Automation'
end
