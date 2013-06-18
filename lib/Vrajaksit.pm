package Vrajaksit;
use Dancer ':syntax';

our $VERSION = '0.1';

get '/' => sub {
    template 'index';
};

get '/upload' => sub {
	template 'upload';
};

get '/download' => sub {
	template 'download';
};

post '/upload_file' => sub {
	my $files  = request->upload('filename');
	info ref($files);
	$files->copy_to('/home/gaurang/git/');
	template 'upload', {
		result => $files->filename . " uploaded successfully"
	};
};

true;
