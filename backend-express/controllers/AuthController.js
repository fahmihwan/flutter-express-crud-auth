const express = require("express");
const prisma = require("../prisma/client");

const bcrypt = require('bcryptjs')

const jwt = require('jsonwebtoken')


const register = async (req, res) => {
    const hashedPassword = await bcrypt.hash(req.body.password, 10)
    try {
        const user = await prisma.user.create({
            data: {
                username: req.body.username,
                password: hashedPassword,
                statusenabled: true
            }
        })

        res.status(201).send({
            success: true,
            message: "user created successfully",
            data: user
        })

    } catch (error) {
        res.status(500).send({
            success: false,
            message: error.message,
        });
    }
}


const login = async (req, res) => {
    try {
        const user = await prisma.user.findFirst({
            where: {
                username: req.body.username
            },
            select: {
                id: true,
                username: true,
                password: true,
            }
        })


        if (!user) {
            return res.status(404).json({
                success: false,
                message: "user not found"
            })
        }

        // compoare password
        const validPassword = await bcrypt.compare(req.body.password, user.password)

        if (!validPassword) {
            return res.status(401).json({
                success: false,
                message: "Invalid password",
            });
        }

        // generate token
        const token = jwt.sign({ id: user.id, }, process.env.JWT_SECRET, {
            expiresIn: "1h",
        })


        const { password, ...userWithoutPassword } = user

        res.status(200).send({
            success: true,
            message: "Login successfully",
            data: {
                user: userWithoutPassword,
                token: token
            }
        })

    } catch (error) {
        res.status(500).send({
            success: false,
            message: error.message
        })
    }
}


const findUserById = async (req, res) => {

    //get ID from params
    const { id } = req.params;

    try {
        //get user by ID
        const user = await prisma.user.findUnique({
            where: {
                id: Number(id)
            }
        })

        res.status(200).send({
            success: true,
            message: `Get user by Id ${id}`,
            data: user,
        })

    } catch (error) {

        res.status(500).send({
            success: false,
            message: "Internal server error"
        })

    }
}


module.exports = { register, login, findUserById }