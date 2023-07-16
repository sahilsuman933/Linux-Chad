import axios from 'axios';
import { SPHERE_ENGINE_API_KEY, SPHERE_ENGINE_API_URL } from '../config';
import { getQuestionById } from '../controller/questionController';

export const verifySolution = async (req, res, next) => {
  try {
    // Extract the questionId and sourceCode from the form data
    const { questionId } = req.body;
    const { sourceCode } = req.body;

    // Step 1: Get the question details from the database
    const question = await getQuestionById(questionId); // Implement the function to get a question by ID from the database
    // Step 2: Submit the solution to Sphere Engine

    const submissionResponse = await submitToSphereEngine(
      question.testCases.input,
      sourceCode,
    );

    console.log(submissionResponse);

    // Step 3: Wait for the code to be executed and retrieve the output
    const submissionId = submissionResponse.data.id;
    const output = await getSubmissionOutput(submissionId);

    // Step 4: Compare the output with the expected output
    const expectedOutput = question.output;
    if (output === expectedOutput) {
      // Solution is correct
      next();
    } else {
      // Solution is incorrect
      res.status(400).json({ error: 'Solution is incorrect' });
    }
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: 'Internal Server Error' });
  }
};

// Helper function to submit code to Sphere Engine
const submitToSphereEngine = async (input, sourceCode) => {
  // const options = {
  //   method: "POST",
  //   url: `${SPHERE_ENGINE_API_URL}/submissions`,
  //   params: { access_token: SPHERE_ENGINE_API_KEY }, // Replace with your actual Sphere Engine access token
  //   headers: { "Content-Type": "application/x-www-form-urlencoded" },
  //   data: { source: sourceCode, compilerId: "116", input },
  // };

  // return axios.request(options);

  const options = {
    method: 'POST',
    url: 'http://localhost:8000/questions/submit-solution',
    headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
    data: {
      questionId: '64b32cecf86068e73bd71741',
      sourceCode:
        'def sum_of_two_numbers():\n    input_str = input()\n    num1_str, num2_str = input_str.split()\n    num1 = int(num1_str)\n    num2 = int(num2_str)\n    sum_result = num1 + num2\n    return sum_result\n\nresult = sum_of_two_numbers()\nprint(result)\n',
    },
  };
  console.log(axios.request(options));
};

// Helper function to get the submission output from Sphere Engine
const getSubmissionOutput = async (submissionId) => {
  const options = {
    method: 'GET',
    url: `${SPHERE_ENGINE_API_URL}/submissions/${submissionId}/output`,
    params: { access_token: SPHERE_ENGINE_API_KEY }, // Replace with your actual Sphere Engine access token
  };

  const response = await axios.request(options);
  return response.data;
};
