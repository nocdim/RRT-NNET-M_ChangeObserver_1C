﻿
&НаСервере
Процедура Выполнить_ТНаСервере(ДанныеФормы)
	Запрос = Новый Запрос;
	Запрос.УстановитьПараметр("Партнер", ДанныеФормы.Партнер);
	Запрос.УстановитьПараметр("Организация", ДанныеФормы.Организация);
	Запрос.УстановитьПараметр("Соглашение", ДанныеФормы.Соглашение);
	Запрос.Текст = "ВЫБРАТЬ
	               |	ПриобретениеТоваровУслуг.Ссылка КАК Ссылка,
	               |	ПриобретениеТоваровУслуг.Дата КАК Дата,
	               |	ПриобретениеТоваровУслуг.Проведен КАК Проведен
	               |ИЗ
	               |	Документ.ПриобретениеТоваровУслуг КАК ПриобретениеТоваровУслуг
	               |ГДЕ
	               |	ПриобретениеТоваровУслуг.Проведен
	               |	И ПриобретениеТоваровУслуг.Партнер = &Партнер
	               |	И ПриобретениеТоваровУслуг.Организация = &Организация
	               |	И ПриобретениеТоваровУслуг.Соглашение = &Соглашение";
	
	ТЗ = Запрос.Выполнить().Выгрузить();
	Для каждого СтрокаТЗ Из ТЗ Цикл
	
		ДокОбъект = СтрокаТЗ.Ссылка.ПолучитьОбъект();
		ДокОбъект.РегистрироватьЦеныПоставщика = Истина;
		Для каждого СтрокаТЧ Из ДокОбъект.Товары Цикл
		
			СтрокаТЧ.ВидЦеныПоставщика = ДанныеФормы.Соглашение.ВидЦеныПоставщика;	
		
		КонецЦикла;
		
		ДокОбъект.Записать(РежимЗаписиДокумента.Проведение, РежимПроведенияДокумента.Неоперативный);
		Сообщить("Документ " + Строка(ДокОбъект.Ссылка) + " был успешно проведен!");
	
	КонецЦикла; 
	
	
КонецПроцедуры

&НаКлиенте
Процедура Выполнить_Т(Команда)
	ДанныеФормы = Новый Структура;
	ДанныеФормы.Вставить("Партнер", Объект.Партнер);
	ДанныеФормы.Вставить("Организация", Объект.Организация);
	ДанныеФормы.Вставить("Соглашение", Объект.Соглашение);
	Попытка
	
		Выполнить_ТНаСервере(ДанныеФормы);	
	
	Исключение
		
		Сообщить("error! " + ОписаниеОшибки());
		
	КонецПопытки; 
	
КонецПроцедуры

&НаКлиенте
Процедура СоглашениеНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
	СтандартнаяОбработка = Ложь;
	НеобходимыеДанныеСтроки = Новый Структура;
	НеобходимыеДанныеСтроки.Вставить("Партнер", Объект.Партнер);
	НеобходимыеДанныеСтроки.Вставить("Организация", Объект.Организация);
	Форма = ОткрытьФорму("Справочник.СоглашенияСПоставщиками.ФормаВыбора",,Элемент,,,,,РежимОткрытияОкнаФормы.БлокироватьОкноВладельца);
	ЭлементОтбора = Форма.Список.Отбор.Элементы.Добавить(Тип("ЭлементОтбораКомпоновкиДанных"));
	ЭлементОтбора.ЛевоеЗначение = Новый ПолеКомпоновкиДанных("Партнер");
	ЭлементОтбора.ВидСравнения = ВидСравненияКомпоновкиДанных.Равно;
	ЭлементОтбора.ПравоеЗначение = НеобходимыеДанныеСтроки.Партнер;
	ЭлементОтбора.Использование = Истина;
	ЭлементОтбора = Форма.Список.Отбор.Элементы.Добавить(Тип("ЭлементОтбораКомпоновкиДанных"));
	ЭлементОтбора.ЛевоеЗначение = Новый ПолеКомпоновкиДанных("Организация");
	ЭлементОтбора.ВидСравнения = ВидСравненияКомпоновкиДанных.Равно;
	ЭлементОтбора.ПравоеЗначение = НеобходимыеДанныеСтроки.Организация;
	ЭлементОтбора.Использование = Истина;
КонецПроцедуры
