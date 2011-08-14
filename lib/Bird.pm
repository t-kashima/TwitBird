package Bird;
use strict;
use warnings;
use Tweet;
use Data::Dumper;

sub new {
		my ($class,%cnf) = @_;
		my $name = delete $cnf{name};
		my $self = bless {
				name => $name || "Anonymous",
				tweets => [],
				followings => {},
				followers => {},				
		},$class;
		return $self;
}

sub get_name {
		my ($self) = @_;
		return $self->{name};
}

sub tweet {
		my ($self,$tweet) = @_;
		return "No tweet." if($tweet eq "");
		push(@{$self->{tweets}},Tweet->new($self,$tweet));
}

sub get_tweets {
		my ($self) = @_;
		return $self->{tweets};
}

sub follow {
		my ($self,$user) = @_;
		if(defined($self->{followings}{$user->get_name}) &&
			 $self->{followings}{$user->get_name} eq "block"){
				return "You have been blocked.";
		} 
		$self->{followings}{$user->get_name} = $user;
		$user->{followers}{$self->get_name} = $self;
}

sub unfollow {
		my ($self,$user) = @_;
		delete $self->{followings}{$user->get_name};
		delete $user->{followers}{$self->get_name};		
}

sub block {
		my ($self,$user) = @_;
		$self->{followers}{$user->get_name} = "block";
		$user->{followings}{$self->get_name} = "block"; 
}

sub unblock {
		my ($self,$user) = @_;
		delete $self->{followers}{$user->get_name};
		delete $user->{followings}{$self->get_name};		
}

sub friends_timeline {
		my ($self) = @_;
		my $timeline = [];
		for my $user (values(%{$self->{followings}})){
				next if($user eq "block");
				for my $tweet (@{$user->get_tweets}){
						if($tweet->{mention} ne "" &&
							 $tweet->{mention} eq $self->get_name){ 
								push(@$timeline,$tweet);
						}elsif($tweet->{mention} eq ""){
								push(@$timeline,$tweet);
						}
				}
		}
		return [ sort { $b->get_id <=> $a->get_id } @$timeline ];
}

1;


