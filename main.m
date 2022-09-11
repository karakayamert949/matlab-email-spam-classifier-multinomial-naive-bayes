clc
clear

%initialprob=350/350 spam/nonspam (train)
fprintf("Please wait the data is processing right now...\n")
[spamWords countSpamWords]=spamTrain();%spam maillerde geçen toplam eşsiz sözcükleri ve kaç kez yer aldıklarını veriyor
[nonSpamWords countNonSpamWords]=nonSpamTrain();%nonspam maillerde geçen toplam eşsiz sözcükleri ve kaç kez yer aldıklarını veriyor
[allWords countAllWords]=makeDict();%trainde geçen eşsiz tüm sözcükleri ve kaç kez yer aldıklarını veriyor. countallwords'u hesaplamada hiç kullanmadım sadece tabloyu oluştumak için ihtiyaç duydum.
%padcat boyut fark etmeksizin vektörleri birleştiriyor eğer o indexte bir
%vektörün değeri yoksa NAN atıyor.
counts=padcat(countAllWords', countSpamWords', countNonSpamWords'); % internetten bulduğum bu fonksiyon stringte sıkıntı çıkartıyor. countallwordsu burada kullandım
table=[allWords' counts];%tablonun 1. sütunu sözcükler, 2.si allwordscount,3.sü spamcount, 4.sü nonspamcount
table(:,2)=[];%allspamcount'a ihtiyaç yok çıkartıyorum. oluşan tablodaki sözcüklerin count değerleri düzensiz.
for i=1:length(allWords) % tüm sözcükleri tarıyorum
    %öncelikle spam ve nonspam countlarını sıfırlıyorum.
    table(i,2)=0;
    table(i,3)=0;
    if find(spamWords(:)==table(i))%tablodaki sözcük spam sözcüklerinden birine eşitse
        table(i,2)=countSpamWords(find(spamWords(:)==table(i)));%o sözcüğün countspam'ini(yani toplam spam maillerinde kaç kez geçtiğini) sözcüğün 2. sütununa yazıyorum. bagofwords olduğu için countspamle spamwordsün indexleri aynı
    end
    if find(nonSpamWords(:)==table(i))
        table(i,3)=countNonSpamWords(find(nonSpamWords(:)==table(i)));
    end
end
%tabloya başlık ekliyorum
head=["Words" "The number of how many times the word exists in spam mails(train data)" "The number of how many times the word exists in nonspam mails(train data)"];
table=[head ; table];
%spam mailleri classify etmek için cd klasörünü değiştir
cd 'C:\Users\mert\Desktop\yazılımlar\yazılım labı 2. dönem\term project\nonspam-test';
liste = dir('*.txt');%çalışılan klasördeki tüm txt dosyalarını listeye atadım
fprintf("Data is succesfully processed. Classification step starts...\n")
countnonspam=0;
countspam=0;
for k = 1:length(liste)%her dosya için
    fname=fileread(liste(k).name);%dosyanın ismini fname'e atadım
    fl=strsplit(fname);%texti sözcüklerine ayırıyor
    fprintf("%s is classified as ",liste(k).name)
    x=clas(fl,table);
    if x==2
        countnonspam=countnonspam+1;
    else
        countspam=countspam+1;
    end
end
fprintf("\n   Classification step is successfully done.\n");
fprintf("   Number of nonspam emails that model classified : %i \n   Number of spam emails that model classified : %i \n   100*Spam/Mails= %f\n",countnonspam,countspam,countspam*100/(countspam+countnonspam));

cd 'C:\Users\mert\Desktop\yazılımlar\yazılım labı 2. dönem\term project';
