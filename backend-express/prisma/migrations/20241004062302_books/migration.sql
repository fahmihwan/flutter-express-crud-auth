-- CreateTable
CREATE TABLE `Books` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `statusenabled` BOOLEAN NOT NULL,
    `title` VARCHAR(255) NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
