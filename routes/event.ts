import express, { Request, Response, NextFunction } from 'express';
import Event from '../models/Event';
import MoyEntry from '../models/MoyEntry';

const router = express.Router();

// Validation middleware
const validateEventFields = (req: Request, res: Response, next: NextFunction) => {
  const { name, date, location, event_type } = req.body;
  const missingFields = [];

  if (!name || name.trim() === '') missingFields.push('name');
  if (!date) missingFields.push('date');
  if (!location || location.trim() === '') missingFields.push('location');
  if (!event_type || event_type.trim() === '') missingFields.push('event_type');

  if (missingFields.length > 0) {
    return res.status(400).json({
      message: 'Missing required fields',
      required: missingFields
    });
  }

  next();
};

// Get all events
router.get('/', async (req, res) => {
  try {
    const events = await Event.findAll({
      order: [['date', 'DESC']]
    });
    return res.json(events);
  } catch (error: unknown) {
    if (error instanceof Error) {
      console.error('Error fetching events:', error);
      return res.status(500).json({ message: 'Internal server error', error: error.message });
    }
    console.error('Unknown error fetching events:', error);
    return res.status(500).json({ message: 'Internal server error' });
  }
});

// Get event by ID
router.get('/:id', async (req, res) => {
  try {
    const event = await Event.findByPk(req.params.id);

    if (!event) {
      return res.status(404).json({ message: 'Event not found' });
    }

    return res.json(event);
  } catch (error: unknown) {
    if (error instanceof Error) {
      console.error('Error fetching event:', error);
      return res.status(500).json({ message: 'Internal server error', error: error.message });
    }
    console.error('Unknown error fetching event:', error);
    return res.status(500).json({ message: 'Internal server error' });
  }
});

// Create new event
router.post('/', validateEventFields, async (req, res) => {
  const { name, date, location, event_type } = req.body;

  try {
    const event = await Event.create({
      name,
      date: new Date(date),
      location,
      event_type
    });

    return res.status(201).json(event);
  } catch (error: unknown) {
    if (error instanceof Error) {
      console.error('Error creating event:', error);
      return res.status(500).json({ message: 'Internal server error', error: error.message });
    }
    console.error('Unknown error creating event:', error);
    return res.status(500).json({ message: 'Internal server error' });
  }
});

// Update event
router.put('/:id', validateEventFields, async (req, res) => {
  const { name, date, location, event_type } = req.body;

  try {
    const event = await Event.findByPk(req.params.id);

    if (!event) {
      return res.status(404).json({ message: 'Event not found' });
    }

    await event.update({
      name,
      date: new Date(date),
      location,
      event_type
    });

    return res.json(event);
  } catch (error) {
    console.error('Error updating event:', error);
    if (error instanceof Error) {
      return res.status(500).json({ message: 'Internal server error', error: error.message });
    }
    return res.status(500).json({ message: 'Internal server error' });
  }
});

// Delete event
router.delete('/:id', async (req, res) => {
  try {
    const event = await Event.findByPk(req.params.id);

    if (!event) {
      return res.status(404).json({ message: 'Event not found' });
    }

    await event.destroy();
    return res.status(200).json({ 
      message: 'Event deleted successfully',
      deletedEvent: {
        id: event.id,
        name: event.name
      }
    });
  } catch (error: unknown) {
    console.error('Error deleting event:', error);
    if (error instanceof Error) {
      return res.status(500).json({ message: 'Internal server error', error: error.message });
    }
    return res.status(500).json({ message: 'Internal server error' });
  }
});

// Get event summary
router.get('/:id/summary', async (req, res) => {
  try {
    const event = await Event.findByPk(req.params.id, {
      include: [{ model: MoyEntry }]
    });

    if (!event) {
      return res.status(404).json({ message: 'Event not found' });
    }

    
    const moyEntries = event.get('MoyEntries') as MoyEntry[];

    const totalAmount = moyEntries.reduce(
      (sum: number, entry: MoyEntry) => sum + Number(entry.amount),
      0
    );

    return res.json({
      eventId: event.id,
      eventName: event.name,
      totalEntries: moyEntries.length,
      totalAmount
    });
  } catch (error) {
    console.error('Error generating event summary:', error);
    return res.status(500).json({ message: 'Internal server error' });
  }
});

// List moy entries for an event
router.get('/:id/moyentries', async (req, res) => {
  try {
    const event = await Event.findByPk(req.params.id, {
      include: [{ model: MoyEntry }]
    });

    if (!event) {
      return res.status(404).json({ message: 'Event not found' });
    }

    
    const moyEntries = event.get('MoyEntries') as MoyEntry[];

    return res.json(moyEntries);
  } catch (error) {
    console.error('Error fetching moy entries:', error);
    return res.status(500).json({ message: 'Internal server error' });
  }
});

export default router;