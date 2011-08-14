package Tweet;
use strict;
use warnings;

our $tweet_id = 0; 
sub new {
		my ($class,$user,$tweet) = @_;
		my $mention_user = "";
		if($tweet =~ /^@(.+?)\s.+?$/){
				$mention_user = $1;
		}
		my $data_structure = {
				id => ++$tweet_id,
				user => $user,
				tweet => $tweet,
				mention => $mention_user,
		};
		my $self = bless $data_structure, $class;
		return $self;
}

sub message {
		my ($self) = @_;
		return $self->{user}->get_name.": ".$self->{tweet};
}

sub get_id {
		my ($self) = @_;
		return $self->{id};
}

1;
