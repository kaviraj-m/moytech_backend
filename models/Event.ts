import { Model, DataTypes } from 'sequelize';
import sequelize from '../config/database';

interface EventAttributes {
  id: number;
  name: string;
  date: Date;
  location: string;
  event_type: string;
  created_at?: Date;
  updated_at?: Date;
}

interface EventCreationAttributes extends Omit<EventAttributes, 'id'> {}

class Event extends Model<EventAttributes, EventCreationAttributes> implements EventAttributes {
  public id!: number;
  public name!: string;
  public date!: Date;
  public location!: string;
  public event_type!: string;
  public readonly created_at!: Date;
  public readonly updated_at!: Date;
}

Event.init(
  {
    id: {
      type: DataTypes.INTEGER,
      autoIncrement: true,
      primaryKey: true,
    },
    name: {
      type: DataTypes.STRING,
      allowNull: false,
    },
    date: {
      type: DataTypes.DATE,
      allowNull: false,
    },
    location: {
      type: DataTypes.STRING,
      allowNull: false,
    },
    event_type: {
      type: DataTypes.STRING,
      allowNull: false,
    },
    created_at: {
      type: DataTypes.DATE,
      allowNull: false,
      defaultValue: DataTypes.NOW,
      field: 'created_at', 
    },
    updated_at: {
      type: DataTypes.DATE,
      allowNull: false,
      defaultValue: DataTypes.NOW,
      field: 'updated_at', 
    },
  },
  {
    sequelize,
    modelName: 'Event',
    tableName: 'Events', 
    timestamps: false, 
  }
);

export default Event;