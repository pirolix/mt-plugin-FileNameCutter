package MT::Plugin::OMV::FileNameCutter;
########################################################################
#   FileNameEliminator

use strict;
no warnings qw( redefine );

use MT::Entry;
my $fn_original_entry = \&MT::Entry::permalink;
*MT::Entry::permalink = sub {
    _cut_filename( $fn_original_entry->( @_ ));
};

use MT::Page;
my $fn_original_page = \&MT::Page::permalink;
*MT::Page::permalink = sub {
    _cut_filename( $fn_original_page->( @_ ));
};

sub _cut_filename {
    my( $url ) = @_;

    # Parse into filepath and anchor part
    my( $filepath, $anchor ) = $url =~ /(.+)(#.+)?/;
    # Eliminate the file-extension part
    $filepath =~ s!\.\w+?$!!;
    # Eliminate the file-name part
    $filepath =~ s!(/)index$!$1!;
    # Results
    $filepath. ($anchor || '');
}

1;