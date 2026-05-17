# Deployment Guide

## Quick Deploy to Vercel

1. Push your code to GitHub
2. Go to [vercel.com](https://vercel.com)
3. Import your repository
4. Deploy

## Firebase Hosting

```bash
npm install -g firebase-tools
firebase login
firebase init hosting
flutter build web --release
firebase deploy
```

## Local Test

```bash
flutter run -d chrome
```

