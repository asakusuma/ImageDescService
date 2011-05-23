require 'zip/zipfilesystem'

class DaisyBookController < ApplicationController
  def upload
  end

  def edit
    book = params[:book]
    if !book
      flash[:alert] = "Must specify a book file to process"
      redirect_to :action => 'upload'
      return
    end
    
    file = File.new( book.path )
    if !valid_daisy_zip?(file)
      flash[:alert] = "Uploaded file must be a valid Daisy (zip) file"
      redirect_to :action => 'upload'
      return
    end
    
    book_directory = unzip_to_temp(file)
    session[:daisy_directory] = book_directory
    
    contents_filename = get_daisy_contents_xml_name(book_directory)
    puts "Rendering #{contents_filename}"
    render :text => File.join(book_directory, contents_filename), :content_type => 'text/plain'
  end

private
  def valid_daisy_zip?(file)
    begin
      Zip::ZipFile.open(file) do |zipfile|
        zipfile.get_entry 'dtbook-2005-3.dtd'
      end
    rescue
      return false
    end
    
    return true
  end
  
  def unzip_to_temp(zipped_file)
    dir = Dir.mktmpdir
    Zip::ZipFile.foreach(zipped_file) do | entry |
      entry.extract(File.join(dir, entry.name))
    end
    return dir
  end
  
  def get_daisy_contents_xml_name(book_directory)
    return Dir.glob(File.join(book_directory, '*.xml'))[0]
  end
end
