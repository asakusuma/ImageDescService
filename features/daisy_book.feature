Feature: Daisy Book

	As a normal user,
	I want to be able to upload a daisy book (zip file)
	So that I can edit the image descriptions
	
	Scenario: Upload page should have the necessary content
		When I go to the daisy upload page
		Then I should see "unencrypted Daisy book (zip) file"

	Scenario: Hitting upload with no book selected
		When I go to the daisy upload page
		And I press "Upload"
		Then I should be on the daisy upload page
		And I should see "Must specify a book file to process"
		
	Scenario: Uploading a non-zip file
		When I go to the daisy upload page
		And I attach the file "features/fixtures/NonXMLFile" to "book"
		And I press "Upload"
		Then I should be on the daisy upload page
		And I should see "Uploaded file must be a valid Daisy (zip) file"
	
	# TODO: Need a scenario for a valid zip that is not a Daisy book
		
	Scenario: Uploading a valid Daisy zip file
		When I go to the daisy upload page
		And I attach the file "features/fixtures/DaisyZipBookUnencrypted.zip" to "book"
		And I press "Upload"
		Then I should be on the description editing page
		# TODO: Make sure book content is visible
		
			
	