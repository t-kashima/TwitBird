package Bird;
use strict;
use warnings;
use Tweet;
use Data::Dumper;

sub new {
		my ($class,%cnf) = @_;
		my $name = delete $cnf{name};
		my $self = bless {
				name => $name,
				tweets => [],
				follows => [],
		},$class;
		return $self;
}

sub get_name {
		my ($self) = @_;
		return $self->{name};
}

sub tweet {
		my ($self,$tweet) = @_;
		push(@{$self->{tweets}},Tweet->new($self,$tweet));
}

sub get_tweets {
		my ($self) = @_;
		return $self->{tweets};
}

sub follow {
		my ($self,$user) = @_;
		for(my $i=0;$i<scalar(@{$self->{follows}});$i++){
				return if($user->get_name eq @{$self->{follows}}[$i]->get_name);
		}
		push(@{$self->{follows}},$user);
}

sub unfollow {
		my ($self,$user) = @_;
		for(my $i=0;$i<scalar(@{$self->{follows}});$i++){
				if($user->get_name eq @{$self->{follows}}[$i]->get_name){
						splice(@{$self->{follows}},$i,1);
						last;
				}
		}
}

sub friends_timeline {
		my ($self) = @_;
		my $timeline = [];
		for my $user (@{$self->{follows}}){
				for my $tweet (@{$user->get_tweets}){
						push(@$timeline,$tweet);
				}
		}
		my @new_timeline = sort { $b->get_id <=> $a->get_id } @$timeline;
		return [@new_timeline];
}

1;

