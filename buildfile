require "buildr/as3"

repositories.remote << "http://artifacts.devboy.org" << "http://repo2.maven.org/maven2"

custom_layout = Layout::Default.new
custom_layout[:source, :main, :as3] = "src/main"
custom_layout[:source, :test, :as3] = "src/test"

define "as3_wooga_utils", :layout => custom_layout do compile.using :compc, :flexsdk => FlexSDK.new("4.5.1.21328")
compile.with _(:libs)
compile.into _(:bin, :main)

test.using :flexunit4 => true
test.compile.options[:main] = _(:src, :test) + "/FlexUnitRunner.mxml"
test.compile.with Buildr::AS3::Test::FlexUnit4.swc_dependencies
test.compile.from compile.sources
test.compile.into _(:bin, :test)
test.compile
end
