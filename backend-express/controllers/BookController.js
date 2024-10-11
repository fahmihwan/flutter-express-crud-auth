const express = require("express");
const prisma = require("../prisma/client");

const index = async (req, res) => {
    // kalau pakai query raw maka nilainya 1
    // const result = await prisma.$queryRaw`SELECT * FROM books WHERE statusenabled=true`;
    // console.log(result);
    // kalau pakai prisma statusenabled bernilai true, hanya berlaku di mysql
    const result = await prisma.books.findMany({
        where: {
            statusenabled: true,
        },
    });

    res.status(200).send({
        data: result,
        success: true,
        message: "list book",
    });
}

const findBookById = async (req, res) => {
    const { id } = req.params;

    const book = await prisma.books.findFirst({
        where: { id: Number(id) }
    });

    res.status(200).send({
        success: true,
        data: book,
        message: "cars created successfully",
    });
}

const storeBook = async (req, res) => {
    try {
        const book = await prisma.books.create({
            data: {
                title: req.body.title,
                statusenabled: true,
            },
        });
        res.status(200).send({
            success: true,
            message: "cars created successfully",
        });
    } catch (error) {
        res.status(500).send({ success: false, message: error.message });
    }
}

const putBook = async (req, res) => {
    const { id } = req.params;

    try {
        const book = await prisma.books.findFirst({
            where: { id: Number(id) },
        });
        if (!book) {
            throw new Error("data not exists");
        }

        let payload = {
            title: req.body.title,
            statusenabled: true,
        };
        const updatebook = await prisma.books.update({
            where: {
                id: Number(id),
            },
            data: payload,
        });

        res.status(200).send({
            success: true,
            message: "cars updated successfully",
        });
    } catch (error) {
        res.status(500).send({
            success: false,
            message: "Internal server error : " + error,
        });
    }
}


const deleteBook = async (req, res) => {
    const { id } = req.params;

    try {
        const book = await prisma.books.findFirst({
            where: { id: Number(id) },
        });
        if (!book) {
            throw new Error("data not exists");
        }
        const result = await prisma.books.update({
            where: {
                id: Number(id),
            },
            data: {
                statusenabled: false,
            },
        });

        res.status(200).send({
            data: result,
            success: true,
            message: "list car by user",
        });
    } catch (error) {
        res.status(500).send({
            success: false,
            message: error,
        });
    }
}


module.exports = { index, findBookById, storeBook, putBook, deleteBook };