/*
  Warnings:

  - The primary key for the `User` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `email` on the `User` table. All the data in the column will be lost.
  - You are about to drop the column `id` on the `User` table. All the data in the column will be lost.
  - You are about to drop the column `name` on the `User` table. All the data in the column will be lost.
  - Added the required column `idx` to the `User` table without a default value. This is not possible if the table is not empty.

*/
-- CreateTable
CREATE TABLE "Profile" (
    "idx" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "name" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "userIdx" INTEGER NOT NULL,
    CONSTRAINT "Profile_userIdx_fkey" FOREIGN KEY ("userIdx") REFERENCES "User" ("idx") ON DELETE CASCADE ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "Post" (
    "idx" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "title" TEXT NOT NULL,
    "description" TEXT NOT NULL,
    "userIdx" INTEGER NOT NULL,
    CONSTRAINT "Post_userIdx_fkey" FOREIGN KEY ("userIdx") REFERENCES "User" ("idx") ON DELETE CASCADE ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "Job" (
    "idx" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "name" TEXT NOT NULL
);

-- CreateTable
CREATE TABLE "Follows" (
    "followerIdx" INTEGER NOT NULL,
    "followingIdx" INTEGER NOT NULL,

    PRIMARY KEY ("followerIdx", "followingIdx"),
    CONSTRAINT "Follows_followerIdx_fkey" FOREIGN KEY ("followerIdx") REFERENCES "User" ("idx") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "Follows_followingIdx_fkey" FOREIGN KEY ("followingIdx") REFERENCES "User" ("idx") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "_JobToUser" (
    "A" INTEGER NOT NULL,
    "B" INTEGER NOT NULL,
    CONSTRAINT "_JobToUser_A_fkey" FOREIGN KEY ("A") REFERENCES "Job" ("idx") ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT "_JobToUser_B_fkey" FOREIGN KEY ("B") REFERENCES "User" ("idx") ON DELETE CASCADE ON UPDATE CASCADE
);

-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_User" (
    "idx" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT
);
DROP TABLE "User";
ALTER TABLE "new_User" RENAME TO "User";
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;

-- CreateIndex
CREATE UNIQUE INDEX "Profile_email_key" ON "Profile"("email");

-- CreateIndex
CREATE UNIQUE INDEX "Profile_userIdx_key" ON "Profile"("userIdx");

-- CreateIndex
CREATE UNIQUE INDEX "_JobToUser_AB_unique" ON "_JobToUser"("A", "B");

-- CreateIndex
CREATE INDEX "_JobToUser_B_index" ON "_JobToUser"("B");
