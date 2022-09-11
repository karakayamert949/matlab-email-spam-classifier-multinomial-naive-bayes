function [allWords countAllWords]=makeDict()
% Text Analytics Toolbox
%trainde geçen eşsiz tüm sözcükleri ve kaç kez yer aldıklarını veriyor.
%countallwords'u hesaplamada hiç kullanmadım sadece tabloyu oluştumak için ihtiyaç duydum.
x="bigMails.txt";%
%class(z) string, tüm dosyadaki text
z=extractFileText(x);
%işleyebilmek için tokenizeddocument classına çevirdim
y=tokenizedDocument(z);
b = removeShortWords(y,1); % 1 harften kısa sözcükleri, soy ad kısaltmasını, a'yı kaldırır. 
allWord=bagOfWords(b);%textteki her sözcüğün kaç kez yer aldığını liste biçiminde verir.
%allWord 1x19074 eşsiz, 191874 tekrarlı, 1 eksik
allWords=allWord.Vocabulary;
countAllWords=full(allWord.Counts);
end