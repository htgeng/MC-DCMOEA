MC-DCMOEA
=========

A Novel Dynamic Constrained Multi-Objective Evolutionary Algorithm Based on Self-adaptive Start-up and Hybrid Crossover

1、main.m 
是MC-DCMOEA的主程序，是运行的入口，此文件中包含对各种实际运行参数的设置，比如评估次数、独立运行参数、不同函数的自变量的上下界、各种算法参数等。

2、init_Population.m
完成进化初始群体的生成。

3、calc_objects.m
完成进化群体的适应度和约束违反程度的计算。在文件中，包含了许多函数的计算，因此需提前对被优化的函数进行单独设定。

4、calc_crowd_distance.m
完成对群体的拥挤距离的计算。

5、cauchyinv.m
是柯西函数的标准例程。

6、compare_indivuals.m
计算两个个体间的支配关系。

7、CreateEmptyParticle.m
初始化优化的粒子

8、CrossOperation.m
完成交叉进化操作。

9、drawObjectPoints.m
对最优前沿进行画图显示。

10、EXA_cut.m
实现对外部精英种群的裁剪。

11、EXA_propagate_mechanism
实现对外部精英种群的繁衍。

12、extract_nondominatedset.m
实现对进化种群的非支配排序。

13、new_pop.m
冷启动产生下一代进化群体。

14、next_Pop.m
热启动产生下一代进化群体。

15、PerformMeasure.m
评价指标的计算。

16、Pop_mutation.m
实现对进化群体的变异操作。

17、updateEXA
实现对外部精英群体的更新操作。

18、updatePopulation.m
实现对进化群体的更新操作。

19、random_operationIndex.m
实现对进化算子的随机选择操作。
