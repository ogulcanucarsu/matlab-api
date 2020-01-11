/*
Get Usd Currency - http://138.68.103.38:3000/currency_type=usd
Get Euro Currency - http://138.68.103.38:3000/currency_type=euro
Get Gold Currency - http://138.68.103.38:3000/currency_type=gold
*/

apiUrl = 'http://138.68.103.38:3000/currency_type=usd';
url = [apiUrl];
response = webread(url)

bankName = []
buyPrice = []
sellPrice = []
minBuyPrice = 0.0
maxSellPrice = 0.0 

for i = 1:numel(response.GetPriceBankListResult)
	if(i == 1)	
	 buyPrice = [str2double(strrep(response.GetPriceBankListResult(i).buyPrice, ',', '.'))];
	 minBuyPrice = str2double(strrep(response.GetPriceBankListResult(i).buyPrice, ',', '.'));
	else
	 buyPrice = [buyPrice,str2double(strrep(response.GetPriceBankListResult(i).buyPrice, ',', '.'))];
		if(minBuyPrice > str2double(strrep(response.GetPriceBankListResult(i).buyPrice, ',', '.')))
			minBuyPrice = str2double(strrep(response.GetPriceBankListResult(i).buyPrice, ',', '.'));
		end
	end
end


for i = 1:numel(response.GetPriceBankListResult)
	if(i == 1)	
	 sellPrice = [str2double(strrep(response.GetPriceBankListResult(i).sellPrice , ',', '.'))];
	 maxSellPrice = str2double(strrep(response.GetPriceBankListResult(i).sellPrice , ',', '.'))
	else
	 sellPrice = [sellPrice,str2double(strrep(response.GetPriceBankListResult(i).sellPrice , ',', '.'))];
		if(maxSellPrice < str2double(strrep(response.GetPriceBankListResult(i).sellPrice , ',', '.')))
			maxSellPrice = str2double(strrep(response.GetPriceBankListResult(i).sellPrice , ',', '.'));
		end
	end
end



for i = 1:numel(response.GetPriceBankListResult)
	if(i == 1)
	 bankName = [string(response.GetPriceBankListResult(i).bankName)];
	else
	 bankName = [bankName,string(response.GetPriceBankListResult(i).bankName)];
	end
end

f = figure
a = axes('YLim',[minBuyPrice  maxSellPrice],'Xtick',1:numel(response.GetPriceBankListResult),'XTickLabel',bankName)
h = line(1:numel(response.GetPriceBankListResult),buyPrice)
k = line(1:numel(response.GetPriceBankListResult),sellPrice)