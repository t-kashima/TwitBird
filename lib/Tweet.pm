package Tweet;
use strict;
use warnings;

our $tweet_id = 0; 
sub new {
		my ($class,$user,$tweet) = @_;
		my $data_structure = {
				id => ++$tweet_id,
				user => $user,
				tweet => $tweet,
				time  => time,
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

sub get_tweet {
		my ($self) = @_;
		return $self->{tweet};
}

sub get_time {
		my ($self) = @_;
		return $self->{time};
}

1;
