function [words countSpamWords]=spamTrain()
% Text Analytics Toolbox
%spam maillerde geçen toplam eşsiz sözcükleri ve kaç kez yer aldıklarını veriyor
%tüm spam dosyalarını tek bir text dosyasında birleştirdim
%aynı işlemleri spam mailler için yaptım
x="bigSpamMail.txt";
z=extractFileText(x);
%işleyebilmek için tokenizeddocument classına çevirdim
y=tokenizedDocument(z);
nWords = numel(strsplit(z)); %1 harfi attıktan sonra!!! spam sözcük sayısı tekrar eden 105771, tekrar etmeyen 8347 tane eşsiz var
b = removeShortWords(y,1); % 1 harften kısa sözcükleri, soy ad kısaltmasını, a'yı kaldırır. 
word=bagOfWords(b);
countSpamWords=full(word.Counts);
words=word.Vocabulary;
end
