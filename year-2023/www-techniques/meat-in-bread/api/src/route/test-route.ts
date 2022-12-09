import express from "express";
import controller from "../controller/test-controller";

const router = express.Router();

router.get('/get', controller.readTest);

export = router;
