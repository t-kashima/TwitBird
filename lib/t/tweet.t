package test::Bird;
use strict;
use warnings;
use base qw(Test::Class);
use Test::More;
use Bird;
use Data::Dumper;

sub init : Test(1) {
    new_ok 'Bird';
}

sub values : Tests {
		my $b1 = Bird->new(name=>'jkondo');
		my $b2 = Bird->new(name=>'reikon');
		my $b3 = Bird->new(name=>'onishi');
		$b1->follow($b2);
		$b1->follow($b3);

		$b3->follow($b1);

		$b1->tweet("今日はあついですね！");
		$b2->tweet("しなもんのお散歩中です");
		$b3->tweet("鳥丸御池なう！");

		my $b1_timelines = $b1->friends_timeline;
		is_deeply [$b1_timelines->[0]->message], ["onishi: 鳥丸御池なう！"];
		is_deeply [$b1_timelines->[1]->message], ["reikon: しなもんのお散歩中です"];
		
		my $b3_timelines = $b3->friends_timeline;
		is_deeply [$b3_timelines->[0]->message], ["jkondo: 今日はあついですね！"];

		$b1->unfollow($b3);
		$b1_timelines = $b1->friends_timeline;
		is_deeply [$b1_timelines->[0]->message], ["reikon: しなもんのお散歩中です"];

		$b1->follow($b3);
		$b1->follow($b3);
		is_deeply [$b1_timelines->[0]->message], ["reikon: しなもんのお散歩中です"];
}

__PACKAGE__->runtests;

1;
