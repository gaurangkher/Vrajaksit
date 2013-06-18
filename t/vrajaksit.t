use strict;
use warnings;

use Test::More;
use Dancer::Test;
use Data::Dumper;
use Vrajaksit;

response_status_is [ GET => '/' ], 200, 'GET / status is ok';


my $response = dancer_response(
	POST => '/upload_file', 
	{
		files => [
			{
				name 	 => 'image', 
				filename => 'filename1i.jpg',
				data	 => "Data1",
			},
			{
				name     => 'application',
				filename => 'filename.exe',
				data     => "Data2",
			}
		]
	}
);

is $response->{status}, 200, "response for POST /upload_file is 200";
like $response->{content}, qr/Files Uploaded Succesfully are/, "Response got from upload"; 

done_testing;
