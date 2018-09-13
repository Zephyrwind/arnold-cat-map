% Aplicaçao do Arnold Cat Map (imagem)
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
ImgOg = imread('cat.jpg');

% Retirar resolucao da imagem e tipo de ficheiro imagem
% canaisCor = 1 significa imagem a preto e branco
% canaisCor = 3 significa imagem RGB
[lines, cols, canaisCor] = size(ImgOg);

% Definir tamanho de letra dos plots
letra = 14;

% Se necessario impor limite para tamanho de imagem a ser lido
% MaxN = 201;

% Garantir que imagem e quadrada. Se nao, fazer quadrada
if lines ~= cols
  N = max([lines,cols]);
% if N > MaxN
%   N = MaxN;
% end
  ImgOg = imresize(ImgOg, [N, N]);  
end 

% Update dos valores
[lines, cols, canaisCor] = size(ImgOg);

% Mostrar imagem original
subplot(1,2,1); % subplot divide janela da figura
imshow(ImgOg);
% axis on;
legenda = sprintf('Imagem Original');
title(legenda, 'FontSize', letra);

% Propriedades de Imagem
% Aumentar figura
set(gcf, 'Units', 'Normalized', 'OuterPosition', [0 0 1 1]);
% Remover barras e menus no topo do ecra
set(gcf, 'Toolbar', 'none', 'Menu', 'none');
% Nome da barra
set(gcf, 'Name', 'Arnold Cat Map', 'NumberTitle', 'Off') ;

% Inicializaçao
ite = 1;
ImgMix= ImgOg;
N = lines;  % dimensao do mapa

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
	legenda = sprintf('Iteracao #%03d', ite);
	fprintf('%s \n', legenda);
	subplot(1, 2, 2);
	imshow(ImgNew);
	% axis on;
	title(legenda, 'FontSize', letra);
	drawnow;
  
  % Por atraso, se necessario
  % pause(0.25);
  
  % Guardar ficheiro, se necessario
  legenda = sprintf('Arnold Cat Ite %03d.jpg', ite);
  print(legenda);
  fprintf('Imagem %s guardada no disco \n', legenda);

  if immse(ImgNew, ImgOg) == 0
    legenda = sprintf('Imagem original apos %03d iteracoes', ite);
    fprintf('%s \n', legenda);
    title(legenda, 'FontSize', letra);
    break;
  end
  
  % Fazer a imagem actual a antiga para a proxima iteracao
  ImgMix = ImgNew;
  % Update do contador
  ite = ite + 1; 
end