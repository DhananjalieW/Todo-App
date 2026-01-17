# Todo App - Complete Setup Guide

A full-stack Todo application with Flutter frontend and Node.js backend, featuring JWT authentication and MVC architecture.

## 📁 Project Structure

```
Todo/
├── backend/                    # Node.js Backend
│   ├── config/
│   │   └── database.js        # MongoDB connection
│   ├── controllers/
│   │   ├── authController.js  # Authentication logic
│   │   └── todoController.js  # Todo CRUD logic
│   ├── middleware/
│   │   └── auth.js            # JWT authentication middleware
│   ├── models/
│   │   ├── User.js            # User schema
│   │   └── Todo.js            # Todo schema
│   ├── routes/
│   │   ├── authRoutes.js      # Auth endpoints
│   │   └── todoRoutes.js      # Todo endpoints
│   ├── .env                   # Environment variables (create this)
│   ├── .env.example           # Example environment variables
│   ├── package.json           # Dependencies
│   └── server.js              # Entry point
│
└── frontend/                  # Flutter Frontend
    ├── lib/
    │   ├── models/
    │   │   ├── user_model.dart
    │   │   └── todo_model.dart
    │   ├── screens/
    │   │   ├── splash_screen.dart
    │   │   ├── login_screen.dart
    │   │   ├── register_screen.dart
    │   │   └── home_screen.dart
    │   ├── services/
    │   │   ├── auth_service.dart
    │   │   └── todo_service.dart
    │   ├── utils/
    │   │   └── constants.dart
    │   ├── widgets/
    │   │   ├── todo_item.dart
    │   │   └── add_todo_dialog.dart
    │   └── main.dart
    └── pubspec.yaml
```

## 🚀 Step-by-Step Setup

### Part 1: MongoDB Atlas Setup

1. **Create MongoDB Atlas Account**
   - Go to https://www.mongodb.com/cloud/atlas
   - Click "Try Free" and create an account
   - Sign in to your account

2. **Create a Cluster**
   - Click "Build a Database"
   - Choose "FREE" (M0) tier
   - Select your preferred cloud provider and region
   - Click "Create Cluster"

3. **Create Database User**
   - Go to "Database Access" in the left sidebar
   - Click "Add New Database User"
   - Choose "Password" authentication
   - Enter username and password (save these!)
   - Set privileges to "Read and write to any database"
   - Click "Add User"

4. **Configure Network Access**
   - Go to "Network Access" in the left sidebar
   - Click "Add IP Address"
   - Click "Allow Access from Anywhere" (for development)
   - Click "Confirm"

5. **Get Connection String**
   - Go to "Database" in the left sidebar
   - Click "Connect" on your cluster
   - Choose "Connect your application"
   - Copy the connection string
   - It looks like: `mongodb+srv://username:<password>@cluster.mongodb.net/...`

### Part 2: Backend Setup (Node.js)

1. **Navigate to backend folder**
   ```bash
   cd backend
   ```

2. **Install Node.js** (if not installed)
   - Download from https://nodejs.org/
   - Choose LTS version
   - Install and verify: `node --version`

3. **Install Dependencies**
   ```bash
   npm install
   ```

4. **Create Environment File**
   - Copy `.env.example` to `.env`:
   ```bash
   copy .env.example .env
   ```

5. **Configure .env file**
   Open `.env` and update:
   ```env
   MONGODB_URI=mongodb+srv://YOUR_USERNAME:YOUR_PASSWORD@cluster.mongodb.net/todoDB?retryWrites=true&w=majority
   JWT_SECRET=your_very_secret_random_string_change_this
   PORT=5000
   JWT_EXPIRE=7d
   ```
   
   Replace:
   - `YOUR_USERNAME` with your MongoDB username
   - `YOUR_PASSWORD` with your MongoDB password
   - Generate a random string for `JWT_SECRET`

6. **Start the Backend Server**
   ```bash
   npm start
   ```
   
   Or for development with auto-reload:
   ```bash
   npm run dev
   ```

7. **Verify Backend is Running**
   - Open browser to http://localhost:5000
   - You should see: `{"message": "Welcome to Todo API"}`

### Part 3: Frontend Setup (Flutter)

1. **Install Flutter** (if not installed)
   - Download from https://flutter.dev/docs/get-started/install
   - Follow instructions for your OS (Windows/Mac/Linux)
   - Add Flutter to PATH
   - Verify: `flutter --version`

2. **Install Flutter Dependencies**
   - Install Android Studio (for Android development)
   - Or Xcode (for iOS development on Mac)
   - Run: `flutter doctor` to check setup

3. **Navigate to frontend folder**
   ```bash
   cd frontend
   ```

4. **Get Flutter Packages**
   ```bash
   flutter pub get
   ```

5. **Configure API URL**
   Open `lib/utils/constants.dart` and set the correct backend URL:
   
   - **For Android Emulator**: Use `http://10.0.2.2:5000/api`
   - **For iOS Simulator**: Use `http://localhost:5000/api`
   - **For Real Device**: Use your computer's IP address like `http://192.168.1.100:5000/api`
   - **For Production**: Use your deployed backend URL

6. **Run the Flutter App**
   
   Start an emulator/simulator or connect a device, then:
   ```bash
   flutter run
   ```

## 🔑 API Endpoints

### Authentication
- `POST /api/auth/register` - Register new user
- `POST /api/auth/login` - Login user
- `GET /api/auth/me` - Get current user (requires auth)

### Todos
- `GET /api/todos` - Get all todos (requires auth)
- `POST /api/todos` - Create new todo (requires auth)
- `GET /api/todos/:id` - Get single todo (requires auth)
- `PUT /api/todos/:id` - Update todo (requires auth)
- `DELETE /api/todos/:id` - Delete todo (requires auth)
- `PATCH /api/todos/:id/toggle` - Toggle todo completion (requires auth)

## 📱 Features

### Backend (MVC Architecture)
- ✅ User registration and login
- ✅ JWT token authentication
- ✅ Password hashing with bcrypt
- ✅ Protected routes with middleware
- ✅ MongoDB integration
- ✅ RESTful API design
- ✅ Error handling
- ✅ CORS enabled

### Frontend
- ✅ Beautiful UI with Material Design
- ✅ User authentication (login/register)
- ✅ Token storage with SharedPreferences
- ✅ Add, view, update, and delete todos
- ✅ Mark todos as complete/incomplete
- ✅ Pull-to-refresh
- ✅ State management with Provider
- ✅ Form validation

## 🧪 Testing the Application

1. **Register a New User**
   - Open the app
   - Click "Register"
   - Enter name, email, and password
   - Click "Register" button

2. **Login**
   - Enter your email and password
   - Click "Login" button

3. **Add Todos**
   - Click the "+" button
   - Enter todo title and description
   - Click "Add"

4. **Manage Todos**
   - Check the checkbox to mark complete
   - Click delete icon to remove
   - Pull down to refresh

## 🔧 Troubleshooting

### Backend Issues

**MongoDB Connection Error**
- Check your internet connection
- Verify MongoDB Atlas IP whitelist includes your IP
- Check username and password in `.env`
- Ensure connection string is correct

**Port Already in Use**
- Change PORT in `.env` to a different number (e.g., 5001)
- Or stop the process using port 5000

### Frontend Issues

**Cannot Connect to Backend**
- Ensure backend is running on port 5000
- Check the API URL in `constants.dart`
- For Android emulator, use `10.0.2.2` instead of `localhost`
- For physical device, use your computer's local IP address

**Flutter Packages Error**
- Run `flutter clean`
- Run `flutter pub get`
- Restart your IDE

## 📚 Learning Resources

### Node.js & Express
- [Node.js Documentation](https://nodejs.org/docs/)
- [Express.js Guide](https://expressjs.com/en/guide/routing.html)

### MongoDB
- [MongoDB Documentation](https://docs.mongodb.com/)
- [Mongoose Guide](https://mongoosejs.com/docs/guide.html)

### Flutter
- [Flutter Documentation](https://flutter.dev/docs)
- [Flutter Cookbook](https://flutter.dev/docs/cookbook)

### JWT Authentication
- [JWT.io](https://jwt.io/introduction)

## 🚀 Next Steps

1. **Add More Features**
   - Edit todo functionality
   - Categories/tags for todos
   - Due dates
   - Priority levels
   - Search functionality

2. **Improve UI/UX**
   - Dark mode
   - Animations
   - Better error messages
   - Loading states

3. **Deploy Your App**
   - Deploy backend to Heroku, Railway, or DigitalOcean
   - Build Flutter app for release
   - Publish to App Store/Play Store

## 📝 Notes

- Never commit your `.env` file to version control
- Change JWT_SECRET to a strong random string in production
- Use environment-specific configurations
- Add proper error handling and validation
- Consider adding API rate limiting
- Implement proper logging

## 🆘 Need Help?

If you encounter issues:
1. Check the console/terminal for error messages
2. Verify all dependencies are installed
3. Ensure MongoDB Atlas is properly configured
4. Check that the backend is running before starting frontend
5. Review the API endpoints and request/response formats

Happy coding! 🎉
