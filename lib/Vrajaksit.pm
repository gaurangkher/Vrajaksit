package Vrajaksit;

use Dancer ':syntax';
use Template;
use Sys::Filesystem;
use File::Find::Rule;
use File::Basename;

our $VERSION = '0.1';

get '/' => sub {
    my $fs = Sys::Filesystem->new();
    my @filesystems = $fs->filesystems();
    my $msg=0;
    if (grep {'/media/gaurang/Elements'} @filesystems) {
    	$msg= 1;
    }
    template 'index';
};

get '/upload' => sub {
		template 'upload', {
			status => 0,
		};
};

get '/download' => sub {
	my @list = File::Find::Rule->file->in('/media/gaurang/Elements/share/');
	my $hash;
	for my $l (@list) {
		my ($file,@arr) = fileparse($l);
		push @{$hash}, { 
			file => $file,
			path => $l
		};
	}
	template 'download', {
		list => $hash,
	};
};

get '/download_file/:name' => sub {
	my $file = params->{name};
	send_file("/media/gaurang/Elements/share/$file",system_path => 1);
	redirect '/download';
};


post '/upload_file' => sub {
	my @files  = request->upload('filename');
	my @names;
	for my $file (@files) {
		push @names, $file->filename;
		$file->copy_to('/media/gaurang/Elements/share/' . $file->filename);
	}
	template 'upload', {
		result => \@names,
		status => 1,
	};
};

true;
