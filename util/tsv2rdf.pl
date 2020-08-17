#!/usr/bin/perl

# SO SORRY ITS PERL

print "\@prefix owl: <http://www.w3.org/2002/07/owl#> .\n";
print "\@prefix rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> .\n";
print "\@prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#> .\n";
print "\@prefix : <http://purl.obolibrary.org/obo/> .\n";
print "\n";
print "## AUTOGENERATED FROM @_\n\n";
while(<>) {
    next if m@^subject@;
    @vals = split(/\t/,$_);
    if (@vals == 2) {
        # skip unmatched
        next;
    }
    if (!$vals[2] || $vals[3]) {
        # skip blanks
        next;
    }
    if (@vals != 6) {
        print STDERR "Expected 6 columns got ", scalar(@vals), "\n";
        foreach my $v (@vals) {
            print STDERR "V: $v \n";
        }
        print STDERR "LINE: $_\n";
        die;
    }
    my ($s, $sn, $p, $o) = @vals;
    next if $p eq 'DIFFERENT';
    $s =~ s@:@_@;
    $o =~ s@:@_@;
    $type = 'owl:Class';
    if ($p =~ m@property@i) {
        $type = 'owl:ObjectProperty';
    }
    print ":$s a $type .\n";
    if ($p eq 'SUPERCLASS_OF') {
        ($s,$o) = ($o,$s);
        $p = 'owl:subClassOf';
    }
    print ":$s $p :$o .\n";
}
