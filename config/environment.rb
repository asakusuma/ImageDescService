# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
DiagramRailsApp::Application.initialize!

Time::DATE_FORMATS[:poet_default] = "%b %d, %Y"
