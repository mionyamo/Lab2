library("lattice")

library("data.table")

# загружаем файл с данными по импорту масла в РФ (из прошлой практики)
fileURL <- 'https://raw.githubusercontent.com/aksyuk/R-data/master/COMTRADE/040510-Imp-RF-comtrade.csv'
# создаём директорию для данных, если она ещё не существует:
if (!file.exists('./data')) {
  dir.create('./data')
}
# создаём файл с логом загрузок, если он ещё не существует:
if (!file.exists('./data/download.log')) {
  file.create('./data/download.log')
}
# загружаем файл, если он ещё не существует,
#  и делаем запись о загрузке в лог:
if (!file.exists('./data/040510-Imp-RF-comtrade.csv')) {
  download.file(fileURL, './data/040510-Imp-RF-comtrade.csv')
  # сделать запись в лог
  write(paste('Файл "040510-Imp-RF-comtrade.csv" загружен', Sys.time()), 
        file = './data/download.log', append = T)
}
# читаем данные из загруженного .csv во фрейм, если он ещё не существует
if (!exists('DT')){
  DT <- data.table(read.csv('./data/040510-Imp-RF-comtrade.csv', as.is = T))
}
# предварительный просмотр
dim(DT)     # размерность таблицы
str(DT)     # структура (характеристики столбцов)
DT          # удобный просмотр объекта data.table

unique(DT$Reporter)

DT <- DT[ , United := '']

for (i in 1:nrow(DT)){ if (DT$Reporter[i] == 'Armenia')
  DT$United[i] <- 'SNG';
if (DT$Reporter[i] == 'Kyrgyzstan')
  DT$United[i] <- 'SNG';
if (DT$Reporter[i] == 'Azerbaijan')
  DT$United <- 'SNG';
if (DT$Reporter[i] == 'Ukraine')
  DT$United[i] <- 'SNG';
if (DT$Reporter[i] == 'Russian Federation')
  DT$United[i] <- 'SNG';
if (DT$Reporter[i] == 'Belarus')
  DT$United[i] <- 'Tamoj';
if (DT$Reporter[i] == 'Kazakhstan')
  DT$United[i] <- 'Tamoj';
if (DT$Reporter[i] == 'Georgia')
  DT$United[i] <- 'Other';
if (DT$Reporter[i] == 'Lithuania')
  DT$United[i] <- 'Other';
if (DT$Reporter[i] == 'New Zealand')
  DT$United[i] <- 'Other';
if (DT$Reporter[i] == 'EU-27')
  DT$United[i] <- 'Other';
if (DT$Reporter[i] == 'Germany')
  DT$United[i] <- 'Other';
if (DT$Reporter[i] == 'Estonia')
  DT$United[i] <- 'Other';
if (DT$Reporter[i] == 'Finland')
  DT$United[i] <- 'Other';
if (DT$Reporter[i] == 'United States of America')
  DT$United[i] <- 'Other';
if (DT$Reporter[i] == 'Latvia')
  DT$United[i] <- 'Other';

 }

cl <- palette(rainbow(3))

bwplot( ~ DT$Trade.Value.USD | factor(DT$United), data=DT, main="bwplot", fill=cl[as.factor(DT$United)])