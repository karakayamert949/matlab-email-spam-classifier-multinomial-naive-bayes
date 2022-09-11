function res=clas(message,table)

probSpam=1;
probNonSpam=1;
%tablodaki sayıları stringten double'a çevirdim, table'ın türü string
%olduğu için sıkıntı çıkartıyordu s adında yeni bir tablo oluşturdum, s
%sadece tablonun countlarını içeriyor
s=str2double(table(:,2:3));
for i=1:length(message) %maildeki sözcük sayısı kadar
    if find(table(:,1)==message(i)) %eğer mesajdaki sözcük tablodaki herhangi bir sözcüğe eşitse
        [row col]=find(table(:,1)==message(i));%tabloda sözcüğün eşit olduğu row gerekli onu buluyoruz col gereksiz 1 zaten
        probSpam=probSpam *10000* (1+s(row,1))/(105771 + 8347);
        probNonSpam=probNonSpam *10000* (1+s(row,2))/(86102 + 14117);
        %probSpam=probSpam * (1+s(row,1))/(2+sum(s(row,1:2))); % bölü 105771 dictionary tüm dataları kapsıyor, eğer sözcük datada yoksa hem spamcounta hem nonspamcounta 1 ekliyor, 1 ekleme olayını her sözcüğe uyguladım, maildeki sözcük tabloda yoksa doğrudan döngüye girmiyor
        %probNonSpam=probNonSpam * (1+s(row,2))/(2+sum(s(row,1:2)));% bölü 86102 sözcük spam maillerde toplam kaç kez geçtiyse bölü toplam maillerde kaç kez geçtiyse
    end
end
%her mail için olasılıkları istiyorsan bunu aç
%probNonSpam;
%probSpam;
res=0;
if probNonSpam>probSpam
    fprintf("nonspam mail. (POB spam=%d, POB nonspam=%d)\n",probSpam,probNonSpam);%result 2'yse nonspam
    res=2;
else
    fprintf("spam mail. (POB spam=%d, POB nonspam=%d)\n",probSpam,probNonSpam);
    res=3;
end
end