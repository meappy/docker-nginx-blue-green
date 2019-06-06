package upstream;
  
sub endpoint {
    my $content;
    my $filename = $_[0];
    open(my $fh, "<", $filename) or die "cannot open file $filename";
    {
        chomp($content = <$fh>);
    }
    close($fh);
    return $content;
}

1;
__END__
