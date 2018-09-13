% Aplicaçao do Arnold Cat Map (varios tamanhos)
% Ref: https://en.wikipedia.org/wiki/Arnold's_cat_map

% Feito por: Claudio Santos, nº 42208, MIEF, FCUL
% Email contacto: claudiostb7@hotmail.com

% Para: Projecto final de Sistemas Dinamicos
% Professor: Jorge Buescu
% Disciplina: Sistemas Dinamicos
% Semestre: 2º
% Ano Lectivo: 2016/2017

% Apagar todas as variaveis antes de comecar
clc;
close all;
clear;

%==============================================================================

% Ler a imagem. Alterar nome da imagem se necessario
ImgOgOg = imread('cat.jpg');

% Retirar resolucao da imagem e tipo de ficheiro imagem
% canaisCor = 1 significa imagem a preto e branco
% canaisCor = 3 significa imagem RGB
[lines, cols, canaisCor] = size(ImgOgOg);

% Se necessario impor limite para tamanho de imagem a ser lido
MaxN = 135;

% Garantir que imagem e quadrada. Se nao, fazer quadrada
if lines ~= cols
  N = max([lines,cols]);
%  if N > MaxN
%  N = MaxN;
% end
  ImgOgOg = imresize(ImgOgOg, [N, N]);  
end 

N = 126;
%data = fopen('data.txt', 'a');
%fprintf(data, 'Lado \t Periodo \n');
%fclose(data);

while N <= MaxN
  
  ImgOg = imresize(ImgOgOg, [N, N]);
  [lines, cols, canaisCor] = size(ImgOg);  
  ite = 1;
  ImgMix= ImgOg;
  
  % E possivel mostrar que o numero max de iteracoes do mapa nao e superior a 3N
  while ite <= 3 * N
  
    for linha = 1 : lines
    
      for coluna = 1 : cols
      
        x = mod((2 * coluna) + linha, N) + 1; % x = numero de colunas
        y = mod(coluna + linha, N) + 1; % y = numero de linhas
      
        ImgNew (linha, coluna, :) = ImgMix (y, x, :);
      end
    end 
  
    % Mostrar imagem actual
	  legenda = sprintf('Iteracao #%03d de img %03d x %03d', ite, N, N);
	  fprintf('%s \n', legenda);

    if immse(ImgNew, ImgOg) == 0
      legenda = sprintf('Img original %03d x %03d apos #%03d iteracoes', N, N, ite);
      fprintf('%s \n', legenda);
      
      data = fopen('data.txt', 'a');
      fprintf(data,'%03d \t %03d \n', N, ite);
      fclose(data);
      break;
    end
  
    % Fazer a imagem actual a antiga para a proxima iteracao
    ImgMix = ImgNew;
    % Update do contador
    ite = ite + 1; 
  end
  
  N = N + 1;
end