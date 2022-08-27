

CREATE TABLE "quizHistories" (
"dateTime" TEXT,
"numTests" INTEGER,
"numRight" INTEGER
);
INSERT INTO "quizHistories" VALUES ('2022-03-02 9:02:00', 1, 1);


CREATE UNIQUE INDEX "dateTime" ON "quizHistories" ("dateTime");