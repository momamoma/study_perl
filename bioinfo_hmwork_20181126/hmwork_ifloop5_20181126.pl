#20181126


$i = 0 ;
$length = 50 ;
#$seq_rand[$i] = "GGGATGGGGATGGGGATGGGGTAA";
#print "$seq_rand[$i]\n" ;
@base = ("a", "t", "g", "c") ;
while ($i <= 10) {
    $i ++ ;
    
    for ($seq_length = 0; $seq_length < $length; $seq_length ++ ) {
        $seq[$i] .= @base[rand(@base)] ;
        $rev_seq[$i] = reverse$seq[$i] ;
        #print "$i\t$seq[$i]\n" ;
        #print "$i\t$rev_seq[$i]\n" ;
    }
    print "\t\t", "____." x 10, "\n" ;
    print "seq$i\t\t$seq[$i]\n" ;
    print "rev_seq$i\t$rev_seq[$i]\n" ;
}

print "探したい配列を入力してください\n" ;
#このブロック中のif文のlastにたどり着くまでループし続ける
print "検索する配列:" ;
OUTER: while (<STDIN>) {
    chomp ($_) ;
    $_ = lc "$_" ;#入力を小文字にする
    #atgcのみからなる1文字以上の配列
    if ($_ =~ /^[atgc]+$/) {
        #print "\$& is $&\n" ;
        $check_seq = $& ;#この変数をその後用いる
        print "\n","下記の配列が入力されました。","\n" x 2, "$check_seq", "\n" x 2 ;
        print "この配列で検索してよろしいですか？\n", "< yes / no >\n" ;
        while (<STDIN>) {
            chomp ($_) ;
            $_ = lc "$_" ;
            if ($_ =~ /^y+/) {
                print "それでは配列を検索します。\n" ;
                print "マッチした配列を大文字で表示します。\n" ;
                for ($i = 1; $i <= 10; $i ++ ) {
                    #print "seq[$i]\t$seq[$i]\n" ;
                    
                    if ($seq[$i] =~ /$check_seq/) {
                        print "\t\t", "____." x 10, "\n" ;
                        print "seq[$i]\t\t$seq[$i]\n" ;
                        $seq[$i] =~ s/$check_seq/uc"$&"/eg ;
                        print "match_seq[$i]\t$seq[$i]\n" ;
                        
                        if ($rev_seq[$i] =~ /$check_seq/) {
                            print "\t\t", "____." x 10, "\n" ;
                            print "rev_seq[$i]\t$rev_seq[$i]\n" ;
                            $rev_seq[$i] =~ s/$check_seq/uc"$&"/eg ;
                            print "match_seq[$i]\t$rev_seq[$i]\n" ;
                            
                        }
                    }
                    elsif ($rev_seq[$i] =~ /$check_seq/) {
                        print "\t\t", "____." x 10, "\n" ;
                        print "rev_seq[$i]\t$rev_seq[$i]\n" ;
                        $rev_seq[$i] =~ s/$check_seq/uc"$&"/eg ;
                        print "match_seq[$i]\t$rev_seq[$i]\n" ;
                        
                    }
                    else {
                        print "\nseq[$i],rev_seq[$i]ともにマッチしませんでした。\n" ;
                    }
                }
                last OUTER ;#外のwhile ブロックを終わらせる
            }
            else {
                print "調べたい配列を再度入力してください。\n" ;
                last ;
            }
        }
        #確認でyesが選択されなかったとき
        print "検索する配列:" ;
        next ;
    }
    #数字の入力はやり直す
    elsif ($_ =~ /\d/) {
        print "数字が含まれています。", "もう一度入力してください。\n" ;
        print "検索する配列:" ;
        #next ;
    }
    #それ以外の文字列もやり直す
    else {
        print "A,T,G,C以外の文字が存在します。", "もう一度入力してください\n" ;
        print "検索する配列:" ;
        #next ;
    }
}

#print "<STDIN> is $check_seq\n" ;

#for ($i = 1; $i <= 10; $i ++ ) {
#    #print "seq[$i]\t$seq[$i]\n" ;
#    if ($seq[$i] =~ /$check_seq/) {
#        print "\t\t", "____." x 10, "\n" ;
#        print "seq[$i]\t\t$seq[$i]\n" ;
#        $seq[$i] =~ s/$check_seq/uc"$&"/eg ;
#        print "match_seq[$i]\t$seq[$i]\n" ;
#    }
#    if ($rev_seq[$i] =~ /$check_seq/) {
#        print "\t\t", "____." x 10, "\n" ;
#        print "rev_seq[$i]\t$rev_seq[$i]\n" ;
#        $rev_seq[$i] =~ s/$check_seq/uc"$&"/eg ;
#        print "match_seq[$i]\t$rev_seq[$i]\n" ;
#    }
#}

