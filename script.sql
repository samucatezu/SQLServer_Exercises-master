/*EX 1
Listar nome e sobrenome ordenado por sobrenome
*/ 
use BDExercicio
SELECT FUNCIONARIOS.nmFuncionario, FUNCIONARIOS.nmSFuncionario from FUNCIONARIOS
ORDER BY FUNCIONARIOS.nmSFuncionario


/*EX 2
Listar todos os campos de funcionários ordenados por cidade
*/ 
SELECT * from FUNCIONARIOS
ORDER BY FUNCIONARIOS.dsCidade

/*EX 3
Liste os funcionários que têm salário superior a R$ 1.000,00 ordenados pelo nome completo
*/ 
SELECT * from FUNCIONARIOS
WHERE FUNCIONARIOS.vlSalario >  1000
ORDER BY FUNCIONARIOS.nmFuncionario, FUNCIONARIOS.nmMFuncionario, FUNCIONARIOS.nmSFuncionario

/*EX 4
Liste a data de nascimento e o primeiro nome dos funcionários ordenados do mais novo para o mais velho
*/ 
SELECT FUNCIONARIOS.DtNascimentoFuncionario, FUNCIONARIOS.nmFuncionario from FUNCIONARIOS
ORDER BY FUNCIONARIOS.DtNascimentoFuncionario ASC

/*EX 5
Liste o total da folha de pagamento
*/ 
SELECT SUM(FUNCIONARIOS.vlSalario) from FUNCIONARIOS

/*EX 6
Liste a quantidade de funcionários desta empresa
*/ 
SELECT COUNT(*) from FUNCIONARIOS

/*EX 7
Liste o salário médio pago pela empresa
*/ 
SELECT AVG(FUNCIONARIOS.vlSalario) AS MediaSalarial
FROM FUNCIONARIOS

/*EX 8
Liste o nome completo de todos os funcionários que não tenham segundo nome
*/ 
SELECT FUNCIONARIOS.nmFuncionario, FUNCIONARIOS.nmMFuncionario, FUNCIONARIOS.nmSFuncionario FROM FUNCIONARIOS
WHERE FUNCIONARIOS.nmMFuncionario IS NULL
ORDER BY FUNCIONARIOS.nmFuncionario,  FUNCIONARIOS.nmSFuncionario

/*EX 9
Liste os nomes dos funcionários que moram em Santos e que exerçam a função de Gerente
*/ 
SELECT FUNCIONARIOS.nmFuncionario
FROM FUNCIONARIOS
WHERE FUNCIONARIOS.dsCidade = 'Santos' AND FUNCIONARIOS.dsCargo = 'Gerente'

/*EX 10
Liste o nome, o nome do departamento e a função de todos os funcionários
*/ 
SELECT FUNCIONARIOS.nmFuncionario, Departamentos.dsDepartamento, FUNCIONARIOS.dsCargo FROM FUNCIONARIOS  JOIN Departamentos 
ON FUNCIONARIOS.CdDepartamento = Departamentos.cdDepartamento
ORDER BY FUNCIONARIOS.nmFuncionario

/*EX 11
Liste todos departamentos com seus respectivos gerentes
*/ 
SELECT Departamentos.dsDepartamento, FUNCIONARIOS.nmFuncionario FROM Departamentos JOIN FUNCIONARIOS 
ON Departamentos.cdDepartamento = FUNCIONARIOS.cdDepartamento AND FUNCIONARIOS.dsCargo = 'Gerente'
ORDER BY Departamentos.dsDepartamento

/*EX 12
Liste o valor da folha de pagamento de cada departamento (nome)
*/ 
SELECT Departamentos.dsDepartamento, SUM(FUNCIONARIOS.vlSalario) 
AS Total
FROM Departamentos JOIN FUNCIONARIOS
ON Departamentos.cdDepartamento = Funcionarios.CdDepartamento
GROUP BY Departamentos.dsDepartamento

/*EX 13
Liste os departamentos dos funcionários que têm a função de supervisor
*/ 
SELECT Departamentos.dsDepartamento, FUNCIONARIOS.nmFuncionario
FROM Departamentos JOIN Funcionarios
ON Departamentos.cdDepartamento = FUNCIONARIOS.CdDepartamento
WHERE FUNCIONARIOS.dsCargo = 'Supervisor'
ORDER BY Departamentos.dsDepartamento

/*EX 14
Liste o menor salário pago pela empresa em cada departamento
*/ 
SELECT Departamentos.dsDepartamento, MIN(FUNCIONARIOS.vlSalario)
FROM FUNCIONARIOS JOIN Departamentos
ON FUNCIONARIOS.CdDepartamento = Departamentos.cdDepartamento
GROUP BY Departamentos.dsDepartamento 

/*EX 15
Liste o nome do departamento e do funcionário ordenados por departamento e funcionário
*/ 
SELECT Departamentos.dsDepartamento, FUNCIONARIOS.nmFuncionario
FROM Departamentos JOIN FUNCIONARIOS ON Departamentos.cdDepartamento = FUNCIONARIOS.CdDepartamento
ORDER BY Departamentos.dsDepartamento, FUNCIONARIOS.nmFuncionario

/*EX 16
Liste os nomes dos funcionários que trabalham no departamento de TI
*/ 
SELECT nmFuncionario FROM FUNCIONARIOS
WHERE FUNCIONARIOS.CdDepartamento = (SELECT Departamentos.cdDepartamento FROM Departamentos WHERE Departamentos.dsDepartamento = 'TI')

/*EX 17
Liste o nome e o departamento de todos os funcionários que ganham mais do que algum gerente
*/ 
SELECT FUNCIONARIOS.nmFuncionario, Departamentos.dsDepartamento
FROM FUNCIONARIOS JOIN Departamentos
ON FUNCIONARIOS.CdDepartamento = Departamentos.cdDepartamento
WHERE FUNCIONARIOS.vlSalario > SOME (
SELECT FUNCIONARIOS.vlSalario
FROM Funcionarios
WHERE FUNCIONARIOS.CdDepartamento IN (
SELECT Departamentos.CdGerente
FROM Departamentos ) );

/*EX 18
Liste todos os funcionários do Departamento de TI se existir algum estagiário neste departamento.
*/ 
SELECT f.*, d.dsDepartamento FROM FUNCIONARIOS f INNER JOIN Departamentos d 
ON f.CdDepartamento = d.cdDepartamento 
WHERE f.dsCargo = 'Estagiário' and d.dsDepartamento = 'TI'

/*EX 19
Exiba o sobrenome ordenado de todos os funcionários que ganham acima da média salarial da companhia.
*/ 
SELECT FUNCIONARIOS.nmSFuncionario FROM FUNCIONARIOS 
WHERE FUNCIONARIOS.vlSalario > (SELECT AVG(FUNCIONARIOS.vlSalario) FROM FUNCIONARIOS)
order by nmFuncionario

/*EX 20
Exiba o ano de nascimento de cada funcionário.
*/ 
SELECT year(FUNCIONARIOS.DtNascimentoFuncionario) from FUNCIONARIOS


/*EX 21
Exiba a diferença em anos entre o funcionário mais velho e o funcionário mais novo da companhia.
*/ 
SELECT max (year(FUNCIONARIOS.DtNascimentoFuncionario)) - min(year(FUNCIONARIOS.DtNascimentoFuncionario)) as DifferenceInYears from FUNCIONARIOS