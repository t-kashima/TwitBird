package test::Bird;
use strict;
use warnings;
use base qw(Test::Class);
use Test::More;
use Bird;

sub init : Test(1) {
    new_ok 'Bird';
}

sub basic : Tests {
		my $b1 = Bird->new();
		is $b1->tweet(""), "No tweet.";
		$b1->tweet("Hello,Kathy.");
		my $b1_timelines = $b1->friends_timeline;
		is_deeply $b1_timelines, [];				

		my $b2 = Bird->new(name=>"Kathy");
		$b1->follow($b2);
		$b2->follow($b1);
		$b2->tweet("Hello.");
		$b1_timelines = $b1->friends_timeline;		
		is $b1_timelines->[0]->message, "Kathy: Hello.";		

		my $b2_timelines = $b2->friends_timeline;		
		is $b2_timelines->[0]->message, "Anonymous: Hello,Kathy.";		

}

sub functions : Tests {
		my $b3 = Bird->new(name=>'Carter');
		my $b4 = Bird->new(name=>'Meg');		
		my $b5 = Bird->new(name=>'Yuta');
		$b3->follow($b4);
		$b3->follow($b5);
		$b4->follow($b3);
		$b4->follow($b5);
		$b5->follow($b3);
		$b5->follow($b4);

		$b3->tweet("Hi, everyone.");		
		$b4->tweet("Hello.");				
		$b5->tweet("Hi.");
		$b3->tweet("\@Meg How are you?"); 

		my $b4_timelines = $b4->friends_timeline;		
		is $b4_timelines->[0]->message, "Carter: \@Meg How are you?";		
		my $b5_timelines = $b5->friends_timeline;		
		is $b5_timelines->[0]->message, "Meg: Hello.";		

		$b4->unfollow($b3);
		$b4_timelines = $b4->friends_timeline;		
		is $b4_timelines->[0]->message, "Yuta: Hi.";		

		$b4->block($b3);
		$b4->tweet("I'm gonna go to shopping.");				
		my $b3_timelines = $b3->friends_timeline;		
		is $b3_timelines->[0]->message, "Yuta: Hi.";		
		is $b3->follow($b4), "You have been blocked.";

		$b4->unblock($b3);
		$b3->follow($b4);
		$b3_timelines = $b3->friends_timeline;		
		is $b3_timelines->[0]->message, "Meg: I'm gonna go to shopping.";		
}

__PACKAGE__->runtests;

1;
