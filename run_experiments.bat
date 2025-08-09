@echo off
set MODELS=resnet50
set STRATEGIES=finetune
set OPTIMIZERS=adam adamw sgd rmsprop adadelta
set LEARNING_RATES=0.01 
REM 0.001 0.0001 0.00001 0.000001

echo Starting automated experiments

FOR %%M IN (%MODELS%) DO (
    FOR %%S IN (%STRATEGIES%) DO (
        FOR %%O IN (%OPTIMIZERS%) DO (
            FOR %%L IN (%LEARNING_RATES%) DO (
                REM This is the condition to SKIP the run.
                IF "%%O"=="adadelta" IF NOT "%%L"=="0.01" (
                    echo SKIPPING: Optimizer=%%O with LR=%%L
                ) ELSE (
                    echo -----------------------------------------------------------------
                    echo STARTING: Model=%%M, Strategy=%%S, Optimizer=%%O, LR=%%L
                    python train.py ^
                        --model %%M ^
                        --strategy %%S ^
                        --optimizer %%O ^
                        --lr %%L
                    echo FINISHED: Model=%%M, Strategy=%%S, Optimizer=%%O, LR=%%L
                    echo.
                )
            )
        )
    )
)

echo All experiment runs are complete.
