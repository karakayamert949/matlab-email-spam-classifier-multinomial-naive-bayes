function [words, countNonSpamWords]=nonSpamTrain()
% Text Analytics Toolbox
%nonspam maillerde geçen toplam eşsiz sözcükleri ve kaç kez yer aldıklarını veriyor
x="bigNonSpamMail.txt"; %tüm nonspam dosyalarını tek bir text dosyasında birleştirdim 
z=extractFileText(x);%string şeklinde texti okuyor
y=tokenizedDocument(z);%işleyebilmek için tokenizeddocument classına çevirdim toolbox'ı kullanabilmek için gerekli
nWords = numel(strsplit(z)); % nonspam sözcük sayısı tekrar eden 86102, tekrar etmeyen 14117 tane eşsiz var
b = removeShortWords(y,1); % 1 harften kısa sözcükleri, soy ad kısaltmasını, a'yı kaldırır. 
%bagofwords data türü kendiliğinden eşsiz sözcükleri oluşturuyor ve textte kaç kez
%geçtiklerini hesaplıyor
word=bagOfWords(b);%bagofwords sparse matrix veriyor https://sebastianraschka.com/faq/docs/bag-of-words-sparsity.html
countNonSpamWords=full(word.Counts); %sparse padcat'le olmuyor burda full'e çevirdim
words=word.Vocabulary;
end